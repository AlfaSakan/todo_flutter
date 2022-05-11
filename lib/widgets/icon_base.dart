import 'package:flutter/material.dart';

class IconBase extends StatelessWidget {
  const IconBase({
    Key? key,
    required this.onTap,
    this.icon,
    this.color,
  }) : super(key: key);

  final void Function() onTap;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
