import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, required this.text, required this.isPassword});

  final String text;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          obscureText: isPassword,
          style: TextStyle(color: AppColors.white),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.lightGray),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.lightGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.green),
            ),
            helperText: text,
            helperStyle: TextStyle(color: AppColors.green),
          ),
        ),
        const SizedBox(
          height: AppSizes.s1,
        )
      ],
    );
  }
}
