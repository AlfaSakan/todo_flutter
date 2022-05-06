import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  static const routeName = 'NotePage';
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Note Page'),
    );
  }
}
