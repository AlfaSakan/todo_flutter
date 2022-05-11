class User {
  late int _id;
  late String _name, _username, _email, _phone;

  int get getId => _id;

  set id(int value) => _id = value;

  String get getUsername => _username;

  set username(String value) => _username = value;

  String get getName => _name;

  set name(String value) => _name = value;

  String get getEmail => _email;

  set email(String value) => _email = value;

  String get getPhone => _phone;

  set phone(String value) => _phone = value;
}
