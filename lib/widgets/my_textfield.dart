import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.text,
    required this.isPassword,
    this.controller,
    this.suffix,
    this.onChange,
  });

  final String text;
  final bool isPassword;
  final TextEditingController? controller;
  final IconButton? suffix;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: onChange,
          controller: controller,
          obscureText: isPassword,
          cursorColor: AppColors.white,
          style: TextStyle(color: AppColors.white),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.green),
            ),
            labelText: text,
            labelStyle: TextStyle(color: AppColors.green),
            suffixIcon: suffix,
          ),
        ),
        const SizedBox(
          height: AppSizes.s1,
        ),
      ],
    );
  }
}
