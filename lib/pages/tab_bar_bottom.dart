import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/pages/pages.dart';

class TabBarBottom extends StatefulWidget {
  static const routeName = 'TabBarBottom';

  const TabBarBottom({Key? key}) : super(key: key);

  @override
  State<TabBarBottom> createState() => _TabBarBottomState();
}

class _TabBarBottomState extends State<TabBarBottom> {
  int tabIndex = 0;
  List<Widget> listScreens = const [
    HomePage(),
    ShoppingPage(),
    NotePage(),
    MoneyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listScreens[tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        onTap: (index) {
          setState(() {
            tabIndex = index;
          });
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Shopping',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Note',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined),
            label: 'Money',
          ),
        ],
      ),
    );
  }
}
