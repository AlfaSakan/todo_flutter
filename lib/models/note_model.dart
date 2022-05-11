class Note {
  late String _activity;
  int _time = DateTime.now().millisecondsSinceEpoch;

  String get getActivity => _activity;

  set activity(String value) {
    _activity = value;
  }

  int get getTime => _time;

  set time(int value) {
    _time = value;
  }

  String formatedDate() {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(_time);
    return '${date.day}-${date.month}-${date.year}';
  }
}
