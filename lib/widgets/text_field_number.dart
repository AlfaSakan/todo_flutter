import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldNumber extends StatelessWidget {
  const TextFieldNumber({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixText,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? prefixText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixText: prefixText,
        hintText: hintText,
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
