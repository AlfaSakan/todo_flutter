import 'package:flutter/material.dart';
import './widgets.dart';

class TextFieldDatePicker extends StatelessWidget {
  const TextFieldDatePicker({
    Key? key,
    this.controller,
    this.labelText,
    this.onTap,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? labelText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFieldBase(
      showCursor: false,
      readOnly: true,
      controller: controller,
      labelText: labelText,
      onTap: onTap,
    );
  }
}
