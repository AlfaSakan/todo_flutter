import 'package:flutter/material.dart';

class MoneyPage extends StatefulWidget {
  static const routeName = 'MoneyPage';
  const MoneyPage({Key? key}) : super(key: key);

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Money Page'),
    );
  }
}
