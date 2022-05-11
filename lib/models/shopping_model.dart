class ShoppingItem {
  String _name = '';
  double _amount = 0;
  String _unit = '';

  String get getName => _name;
  double get getAmount => _amount;
  String get getUnit => _unit;

  set name(String value) {
    _name = value;
  }

  set amount(double value) {
    _amount = value;
  }

  set unit(String value) {
    _unit = value;
  }

  addAmount(double value) {
    _amount += value;
  }

  subtractAmount(double value) {
    _amount -= value;
  }
}
