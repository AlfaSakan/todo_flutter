class MoneyFlow {
  late int _amount;
  late String _description = '';
  late bool _isIncome = true;

  int get getAmount => _amount;
  bool get getIsIncome => _isIncome;
  String get getDescription => _description;

  String typeMoneyFlow() {
    if (_isIncome) {
      return 'Pemasukan';
    }
    return 'Pengeluaran';
  }

  set amount(int value) {
    _amount = value;
  }

  set description(String value) {
    _description = value;
  }

  set isIncome(bool value) {
    _isIncome = value;
  }
}
