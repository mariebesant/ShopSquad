import 'package:flutter/material.dart';
import 'package:shopsquad/pages/main_pages.dart';
import 'package:shopsquad/pages/main_pages/list_page.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/my_textfield.dart';

class AddGroup extends StatelessWidget {
  const AddGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<dynamic>(
                builder: (context) => MainPages(),
              ),
            ),
            child: Text(
              'Erstellen',
              style: TextStyle(color: AppColors.white, fontSize: AppSizes.s1),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.s1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: AppSizes.s5,
              ),
              MyTextField(
                text: 'Gruppenname',
                isPassword: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
