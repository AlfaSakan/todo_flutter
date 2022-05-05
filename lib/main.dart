import 'package:flutter/material.dart';
import 'package:todo_list_flutter/pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: TabBarBottom.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        TabBarBottom.routeName: (context) => const TabBarBottom(),
      },
    );
  }
}
