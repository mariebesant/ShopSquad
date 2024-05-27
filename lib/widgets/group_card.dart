import 'package:flutter/material.dart';
import 'package:shopsquad/pages/main_pages/to_do_page.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({super.key, required this.title});

  final String title;

  static const IconData dots = IconData(0xe404, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.s0_5,
        horizontal: AppSizes.s1,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ToDoPage(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.accentGray,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(color: AppColors.white),
            ),
            trailing: Icon(dots, color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
