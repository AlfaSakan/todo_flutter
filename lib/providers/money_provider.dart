import 'package:flutter/material.dart';
import '../models/models.dart';

class MoneyHistory with ChangeNotifier {
  List<MoneyFlow> _historyList = [];

  List<MoneyFlow> get getHistoryList => _historyList;

  void addHistory(MoneyFlow value) {
    _historyList.add(value);
    notifyListeners();
  }

  void removeHistoryAt(int indexItem) {
    _historyList.removeAt(indexItem);
    notifyListeners();
  }

  void resetHistory() {
    _historyList = [];
    notifyListeners();
  }

  int totalWallet() {
    int total = 0;
    for (var money in _historyList) {
      if (money.getIsIncome) {
        total += money.getAmount;
        continue;
      }
      total -= money.getAmount;
    }

    return total;
  }
}
