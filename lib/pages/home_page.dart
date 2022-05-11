import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          ],
        ),
      ),
    );
  }
}
