import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.text,
    required this.color,
    required this.backgroundColor,
    required this.onPressed,
    this.icon,
  }) : super(key: key);

  final String text;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onPressed; // Typ auf VoidCallback geändert
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, // onPressed ohne Argument
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: (icon != null) ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
        children: [
          if (icon != null) icon!,
          Text(
            text,
            style: TextStyle(color: color, fontSize: AppSizes.s1),
          ),
        ],
      ),
    );
  }
}
