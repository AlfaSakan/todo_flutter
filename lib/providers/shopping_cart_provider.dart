import 'package:flutter/material.dart';
import '../models/shopping_model.dart';

class ShoppingCart with ChangeNotifier {
  List<ShoppingItem> _shoppingItems = [];

  // set setShoppingItems(List<ShoppingItem> value) {
  //   _shoppingItems = value;
  // }

  List<ShoppingItem> get getShoppingItems => _shoppingItems;

  void addShoppingItem(ShoppingItem newItem) {
    _shoppingItems.add(newItem);
    notifyListeners();
  }

  void removeShoppingItemAt(int indexItem) {
    _shoppingItems.removeAt(indexItem);
    notifyListeners();
  }

  void resetCart() {
    _shoppingItems = [];
    notifyListeners();
  }
}
