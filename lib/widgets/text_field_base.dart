import 'package:flutter/material.dart';

class TextFieldBase extends StatelessWidget {
  const TextFieldBase({
    Key? key,
    this.controller,
    this.labelText,
    this.onTap,
    this.readOnly = false,
    this.showCursor,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? labelText;
  final void Function()? onTap;
  final bool readOnly;
  final bool? showCursor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      showCursor: showCursor,
      onTap: onTap,
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
