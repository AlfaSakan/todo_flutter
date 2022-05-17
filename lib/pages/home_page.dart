import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../widgets/widgets.dart';
import '../helpers/helpers.dart';
import '../providers/providers.dart';
import '../models/models.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, bool> itemInCart = {};
  final Map<String, bool> notesDone = {};
  int totalWallet = 0;

  @override
  Widget build(BuildContext context) {
    List<ShoppingItem> shoppingCart =
        context.watch<ShoppingCart>().getShoppingItems;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Mama Choice',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Keranjang Belanja',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  shoppingCart.length.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16),
              ),
              height: 250,
              width: double.infinity,
              child: shoppingCart.isEmpty
                  ? const Center(
                      child: Icon(
                        Icons.remove_shopping_cart_outlined,
                        size: 70,
                        color: Colors.grey,
                      ),
                    )
                  : ListView.builder(
                      itemCount: shoppingCart.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            toTitleCase(shoppingCart[index].getName),
                            style: TextStyle(
                              decoration:
                                  itemInCart[shoppingCart[index].getName] ??
                                          false
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                              '${shoppingCart[index].getAmount}${shoppingCart[index].getUnit}'),
                          leading: const Icon(
                            Icons.shop,
                            color: Colors.green,
                          ),
                          trailing: InkWell(
                            onDoubleTap: () {
                              var cart = context.read<ShoppingCart>();
                              cart.removeShoppingItemAt(index);
                            },
                            onTap: () {
                              setState(() {
                                if (itemInCart[shoppingCart[index].getName] ??
                                    false) {
                                  itemInCart[shoppingCart[index].getName] =
                                      false;
                                  return;
                                }
                                itemInCart[shoppingCart[index].getName] = true;
                                var cart = context.read<ShoppingCart>();
                                cart.addShoppingItem(shoppingCart[index]);
                                cart.removeShoppingItemAt(index);
                              });
                            },
                            child: Icon(
                              itemInCart[shoppingCart[index].getName] ?? false
                                  ? Icons.check_circle_outline
                                  : Icons.radio_button_unchecked,
                              color: Colors.green,
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Catatan Harian',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Consumer<NotesList>(
                  builder: (context, value, child) {
                    return Text(
                      value.getNotes.length.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Consumer<NotesList>(
              builder: (context, value, child) {
                var notes = value.getNotes;

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 250,
                  width: double.infinity,
                  child: notes.isEmpty
                      ? const Center(
                          child: Icon(
                            Icons.remove_shopping_cart_outlined,
                            size: 70,
                            color: Colors.grey,
                          ),
                        )
                      : ListView.builder(
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                toTitleCase(notes[index].getActivity),
                                style: TextStyle(
                                  decoration:
                                      notesDone[notes[index].getActivity] ??
                                              false
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(notes[index].displayTime()),
                              leading: const Icon(
                                Icons.shop,
                                color: Colors.green,
                              ),
                              trailing: InkWell(
                                onDoubleTap: () {
                                  value.removeNoteAt(index);
                                },
                                onTap: () {
                                  setState(() {
                                    if (notesDone[notes[index].getActivity] ??
                                        false) {
                                      notesDone[notes[index].getActivity] =
                                          false;
                                      return;
                                    }
                                    notesDone[notes[index].getActivity] = true;
                                    value.addNote(notes[index]);
                                    value.removeNoteAt(index);
                                  });
                                },
                                child: Icon(
                                  notesDone[notes[index].getActivity] ?? false
                                      ? Icons.check_circle_outline
                                      : Icons.radio_button_unchecked,
                                  color: Colors.green,
                                ),
                              ),
                            );
                          },
                        ),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Catatan Keuangan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Consumer<MoneyHistory>(
                  builder: (context, value, child) {
                    return Text(
                      NumberFormat.currency(
                        locale: 'id',
                        decimalDigits: 0,
                      ).format(
                        value.totalWallet(),
                      ),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Consumer<MoneyHistory>(
              builder: (context, value, child) {
                var moneyHistory = value.getHistoryList;

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 250,
                  width: double.infinity,
                  child: moneyHistory.isEmpty
                      ? const Center(
                          child: Icon(
                            Icons.remove_shopping_cart_outlined,
                            size: 70,
                            color: Colors.grey,
                          ),
                        )
                      : ListView.builder(
                          itemCount: moneyHistory.length,
                          itemBuilder: (context, index) {
                            bool isIncome =
                                value.getHistoryList[index].getIsIncome;

                            return ListTile(
                              title: Text(
                                NumberFormat.currency(
                                  locale: 'id',
                                  decimalDigits: 0,
                                ).format(
                                  value.getHistoryList[index].getAmount,
                                ),
                                style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle:
                                  Text(moneyHistory[index].getDescription),
                              leading: Icon(
                                isIncome
                                    ? Icons.arrow_downward_outlined
                                    : Icons.arrow_upward_rounded,
                                color: isIncome ? Colors.green : Colors.red,
                              ),
                            );
                          },
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
