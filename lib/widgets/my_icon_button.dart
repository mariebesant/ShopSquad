import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';

enum CurrentSlide { list, group, profile }

class MyIconButton extends StatelessWidget {
  const MyIconButton(
      {super.key,
      required this.isSelected,
      required this.currentSlide,
      required this.onPressed,
      required this.icon});

  final bool isSelected;
  final String currentSlide;
  final VoidCallback? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          isSelected: isSelected,
          onPressed: onPressed,
          padding: EdgeInsets.zero,
          iconSize: AppSizes.s1_75,
          icon: Icon(
            icon,
            color: isSelected ? AppColors.success : AppColors.lightGray,
          ),
        ),
        Text(
          currentSlide,
          style: TextStyle(
              color: isSelected ? AppColors.success : AppColors.lightGray, fontSize: AppSizes.s0_75),
        ),
        const SizedBox(
          height: AppSizes.s0_5,
        ),
        Container(
          height: AppSizes.s0_25,
          width: AppSizes.s7,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.success : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ],
    );
  }
}
