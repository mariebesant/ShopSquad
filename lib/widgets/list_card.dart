import 'package:flutter/material.dart';
import 'package:shopsquad/pages/main_pages/to_do_page.dart';

import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  static const IconData moneyIcon =
      IconData(0xf1dd, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.s0_5,
        horizontal: AppSizes.s1,
      ),
      child: InkWell(
        // Wrap Container with InkWell to make it clickable
        onTap: () {
          Navigator.of(context).push(
            // Navigate to ListPage
            MaterialPageRoute(
              builder: (context) => ToDoPage(),
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
            subtitle: Text(
              subtitle,
              style: TextStyle(
                color: AppColors.white,
                fontSize: AppSizes.s0_75,
                fontWeight: FontWeight.w300,
              ),
            ),
            trailing: Icon(moneyIcon, color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
