import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../helpers/helpers.dart';

class ShoppingPage extends StatefulWidget {
  static const routeName = 'ShoppingPage';
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  bool _isEdit = false;
  int _choosenIndex = -1;
  late TextEditingController _controllerGoods,
      _controllerAmount,
      _controllerUnit;

  @override
  void initState() {
    super.initState();
    _controllerGoods = TextEditingController();
    _controllerAmount = TextEditingController();
    _controllerUnit = TextEditingController();
  }

  @override
  void dispose() {
    _controllerGoods.dispose();
    _controllerAmount.dispose();
    _controllerUnit.dispose();
    super.dispose();
  }

  onAddItem(DataNotifier notifier, String itemName, double itemAmount,
      String itemUnit, BuildContext context) {
    if (itemName.isEmpty || itemUnit.isEmpty || itemAmount.isNaN) {
      return;
    }

    bool isExist = notifier.getShoppingItems.any((shoppingItem) =>
        shoppingItem.name.toLowerCase() == itemName.toLowerCase());

    if (isExist) {
      showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Barang di Keranjang'),
            content: const Text('Barang ini sudah ada dalam keranjang'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    ShoppingItem newItem = ShoppingItem(itemName, itemAmount, itemUnit);

    setState(() {
      notifier.addShoppingItem(newItem);
      _controllerAmount.clear();
      _controllerUnit.clear();
      _controllerGoods.clear();
      _isEdit = false;
    });
  }

  onEditItem(DataNotifier notifier, String itemName, double itemAmount,
      String itemUnit) {
    setState(() {
      ShoppingItem choosenItem = notifier.getShoppingItems[_choosenIndex];
      choosenItem.setterName(itemName);
      choosenItem.setterUnit(itemUnit);
      choosenItem.amount = itemAmount;

      _controllerAmount.clear();
      _controllerUnit.clear();
      _controllerGoods.clear();
      _isEdit = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _dataNotifier = context.watch<ValueNotifier<DataNotifier>>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          children: [
            TextField(
              controller: _controllerGoods,
              decoration: const InputDecoration(
                labelText: 'Nama Barang',
                border: OutlineInputBorder(),
                floatingLabelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controllerAmount,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah Barang',
                border: OutlineInputBorder(),
                floatingLabelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controllerUnit,
              decoration: const InputDecoration(
                labelText: 'Satuan Barang',
                border: OutlineInputBorder(),
                floatingLabelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                if (_isEdit) {
                  onEditItem(
                    _dataNotifier.value,
                    _controllerGoods.text,
                    double.parse(_controllerAmount.text.isEmpty
                        ? '0'
                        : _controllerAmount.text),
                    _controllerUnit.text,
                  );
                  return;
                }

                onAddItem(
                  _dataNotifier.value,
                  _controllerGoods.text,
                  double.parse(_controllerAmount.text.isEmpty
                      ? '0'
                      : _controllerAmount.text),
                  _controllerUnit.text,
                  context,
                );
              },
              child: Text(
                _isEdit ? 'Ubah Data Barang' : 'Tambah ke Daftar',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            ..._dataNotifier.value.getShoppingItems.asMap().entries.map(
              (item) {
                return ListTile(
                  title: Text(toTitleCase(item.value.name)),
                  subtitle: Text('${item.value.amount}${item.value.unit}'),
                  leading: const Icon(
                    Icons.shop,
                    color: Colors.green,
                  ),
                  trailing: Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _dataNotifier.value
                                  .removeShoppingItemAt(item.key);
                            });
                          },
                          child: const Icon(
                            Icons.remove_circle_outline,
                            color: Colors.red,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _controllerGoods.text = item.value.name;
                              _controllerAmount.text =
                                  item.value.amount.toString();
                              _controllerUnit.text = item.value.unit;
                              _isEdit = true;
                              _choosenIndex = item.key;
                            });
                          },
                          child: const Icon(
                            Icons.edit,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
