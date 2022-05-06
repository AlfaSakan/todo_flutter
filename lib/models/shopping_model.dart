class ShoppingItem {
  ShoppingItem(this.name, this.amount, this.unit);

  String name;
  double amount;
  String unit;

  addAmount(double value) {
    amount += value;
  }

  subtractAmount(double value) {
    amount -= value;
  }

  setterName(newName) {
    name = newName;
  }

  setterUnit(newUnit) {
    unit = newUnit;
  }
}
