import 'package:flutter/material.dart';

class TabBarBottom extends StatefulWidget {
  static const routeName = 'TabBarBottom';

  const TabBarBottom({Key? key}) : super(key: key);

  @override
  State<TabBarBottom> createState() => _TabBarBottomState();
}

class _TabBarBottomState extends State<TabBarBottom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
