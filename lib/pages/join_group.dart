import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/my_textfield.dart';
import 'package:shopsquad/pages/main_pages/list_page.dart';

class JoinGroup extends StatelessWidget {
  const JoinGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<dynamic>(
                builder: (context) => const ListPage(),
              ),
            ),
            child: Text(
              'Beitreten',
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
                text: 'Gib einen Code ein',
                isPassword: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
