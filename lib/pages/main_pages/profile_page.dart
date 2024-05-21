import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/credits.dart';
import 'package:shopsquad/widgets/profile.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String credit = '-23,78';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: AppSizes.s1,
        ),
        Text(
          credit,
          style: TextStyle(
              color: AppColors.warning,
              fontSize: AppSizes.s2,
              fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: AppSizes.s0_5,
        ),
        Text(
          'saldo',
          style: TextStyle(
              color: AppColors.lightGray,
              fontSize: AppSizes.s1,
              fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: AppSizes.s3_5,
        ),
        const Profile()
      ],
    );
  }
}
