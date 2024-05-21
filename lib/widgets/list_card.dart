import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/progress_indicator.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    this.onTap,
  });

  final String title;
  final MyProgressIndicator subtitle;
  final Color backgroundColor;
  final VoidCallback? onTap; // onTap Callback hinzugefügt

  static const IconData moneyIcon =
      IconData(0xf1dd, fontFamily: 'MaterialIcons');

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
            trailing: Icon(moneyIcon, color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
