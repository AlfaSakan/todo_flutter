import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../helpers/helpers.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

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

  void _onAddItem(String itemName, double itemAmount, String itemUnit,
      BuildContext context) {
    if (itemName.isEmpty || itemUnit.isEmpty || itemAmount.isNaN) {
      return;
    }

    bool isExist = context.read<ShoppingCart>().getShoppingItems.any(
        (shoppingItem) =>
            shoppingItem.getName.toLowerCase() == itemName.toLowerCase());

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

    ShoppingItem newItem = ShoppingItem();
    newItem.name = itemName;
    newItem.amount = itemAmount;
    newItem.unit = itemUnit;

    context.read<ShoppingCart>().addShoppingItem(newItem);

    setState(() {
      _controllerAmount.clear();
      _controllerUnit.clear();
      _controllerGoods.clear();
      _isEdit = false;
    });
  }

  void _onPressedEditItem(MapEntry<int, ShoppingItem> data) {
    setState(() {
      _controllerGoods.text = data.value.getName;
      _controllerAmount.text = data.value.getAmount.toString();
      _controllerUnit.text = data.value.getUnit;
      _isEdit = true;
      _choosenIndex = data.key;
    });
  }

  void _onEditItem(
      ShoppingCart cart, String itemName, double itemAmount, String itemUnit) {
    ShoppingItem choosenItem = cart.getShoppingItems[_choosenIndex];
    choosenItem.name = itemName;
    choosenItem.unit = itemUnit;
    choosenItem.amount = itemAmount;

    setState(() {
      _controllerAmount.clear();
      _controllerUnit.clear();
      _controllerGoods.clear();
      _isEdit = false;
    });
  }

  void _onSubmit() {
    if (_isEdit) {
      _onEditItem(
        context.read<ShoppingCart>(),
        _controllerGoods.text,
        double.parse(
            _controllerAmount.text.isEmpty ? '0' : _controllerAmount.text),
        _controllerUnit.text,
      );
      return;
    }

    _onAddItem(
      _controllerGoods.text,
      double.parse(
          _controllerAmount.text.isEmpty ? '0' : _controllerAmount.text),
      _controllerUnit.text,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keranjang Belanja',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        children: [
          TextFieldBase(
            controller: _controllerGoods,
            labelText: 'Nama Barang',
          ),
          const SizedBox(height: 20),
          TextFieldNumber(
            controller: _controllerAmount,
            labelText: 'Jumlah Barang',
          ),
          const SizedBox(height: 20),
          TextFieldBase(
            controller: _controllerUnit,
            labelText: 'Satuan Barang',
          ),
          const SizedBox(height: 20),
          ButtonBase(
            text: _isEdit ? 'Ubah Data Barang' : 'Tambah ke Daftar',
            onPressed: _onSubmit,
          ),
          const SizedBox(height: 20),
          ...context.watch<ShoppingCart>().getShoppingItems.asMap().entries.map(
            (item) {
              return ListTile(
                title: Text(toTitleCase(item.value.getName)),
                subtitle: Text('${item.value.getAmount}${item.value.getUnit}'),
                leading: const Icon(
                  Icons.shop,
                  color: Colors.green,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconBase(
                      onTap: () {
                        context
                            .read<ShoppingCart>()
                            .removeShoppingItemAt(item.key);
                      },
                      icon: Icons.remove_circle_outline,
                      color: Colors.red,
                    ),
                    IconBase(
                      onTap: () => _onPressedEditItem(item),
                      icon: Icons.edit,
                      color: Colors.amber,
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}
