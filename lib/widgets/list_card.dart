import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart'; 

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.trailing,
    this.onTap,
  });

  final String title;
  final Widget subtitle;
  final Color backgroundColor;
  final Widget trailing;
  final VoidCallback? onTap; // onTap Callback hinzugefügt

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.s0_5,
        horizontal: AppSizes.s1,
      ),
      child: GestureDetector(
        onTap: onTap, // onTap Funktion hier genutzt
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(color: AppColors.white),
            ),
            subtitle: subtitle,
            trailing: trailing,
          ),
        ),
      ),
    );
  }
}
