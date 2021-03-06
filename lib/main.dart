import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';
import 'pages/pages.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ShoppingCart>(create: (_) => ShoppingCart()),
        ChangeNotifierProvider<NotesList>(create: (_) => NotesList()),
        ChangeNotifierProvider<MoneyHistory>(create: (_) => MoneyHistory()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: TabBarBottom.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        TabBarBottom.routeName: (context) => const TabBarBottom(),
        ShoppingPage.routeName: (context) => const ShoppingPage(),
      },
    );
  }
}
