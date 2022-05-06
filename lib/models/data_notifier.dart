import 'package:todo_list_flutter/models/shopping_model.dart';

class DataNotifier {
  List<ShoppingItem> _shoppingItems = [];

  set setShoppingItems(List<ShoppingItem> value) {
    _shoppingItems = value;
  }

  List<ShoppingItem> get getShoppingItems => _shoppingItems;

  addShoppingItem(ShoppingItem newItem) {
    _shoppingItems.add(newItem);
  }

  removeShoppingItemAt(int indexItem) {
    _shoppingItems.removeAt(indexItem);
  }
}
