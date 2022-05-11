import 'package:flutter/material.dart';

class TextFieldNumber extends StatelessWidget {
  const TextFieldNumber({Key? key, this.controller, this.labelText})
      : super(key: key);

  final TextEditingController? controller;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
