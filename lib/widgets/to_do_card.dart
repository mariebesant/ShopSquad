import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/checkbox.dart';

class ToDoCard extends StatelessWidget {
  ToDoCard({
    super.key,
    required this.isSortByPerson,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.isChecked, // Add this line
    required this.onChanged, // Add this line
  });

  final bool isSortByPerson;
  final String title;
  final int subtitle;
  final int trailing;
  final bool isChecked; // Add this line
  final ValueChanged<bool?> onChanged; // Add this line

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.s0_5, horizontal: AppSizes.s1),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.accentGray,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          leading: Checkbox(
            value: isChecked,
            onChanged: onChanged, // Update this line
          ),
          title: Text(
            title,
            style: TextStyle(
                color: isSortByPerson ? AppColors.green : AppColors.white),
          ),
          subtitle: Text(
            '${subtitle.toString()}€',
            style: TextStyle(
                color: AppColors.white,
                fontSize: AppSizes.s0_75,
                fontWeight: FontWeight.w300),
          ),
          trailing: Text(trailing.toString(), style: TextStyle(color: AppColors.green)),
        ),
      ),
    );
  }
}
