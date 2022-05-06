import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final dataNotifier = context.watch<ValueNotifier<DataNotifier>>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'InstaPhoto',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text('Home Page'),
        ),
      ),
    );
  }
}
