import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';

class Profile extends StatelessWidget{
  const Profile({super.key});

  static const IconData logoutIcon =
      IconData(0xf88b, fontFamily: 'MaterialIcons');
  static const IconData moneyIcon = IconData(0xf58f, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.s1_25, vertical: AppSizes.s0_75),
          child: GestureDetector(
            onTap: () {
              
            },
            child: Row(
              children: [
                Icon(
                  logoutIcon,
                  color: AppColors.lightGray,
                ),
                const SizedBox(
                  width: AppSizes.s1,
                ),
                Text('Abmelden', style: TextStyle(color: AppColors.lightGray, fontSize: AppSizes.s1_25),),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.s1_25, vertical: AppSizes.s0_75),
          child: GestureDetector(
            onTap: () {
              
            },
            child: Row(
              children: [
                Icon(
                  moneyIcon,
                  color: AppColors.lightGray,
                ),
                const SizedBox(
                  width: AppSizes.s1,
                ),
                Text('Schulden', style: TextStyle(color: AppColors.lightGray, fontSize: AppSizes.s1_25),),
              ],
            ),
          ),
        )],);
  }

}