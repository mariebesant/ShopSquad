import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';

class MyProgressIndicator extends StatelessWidget {
  final int totalTasks;
  final int completedTasks;

  const MyProgressIndicator({
    super.key,
    required this.totalTasks,
    required this.completedTasks,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = completedTasks / totalTasks;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: AppSizes.s0_5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.lightGray,
            ),
            child: Stack(
              children: [
                FractionallySizedBox(
                  widthFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.success,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSizes.s0_75,),
        Text('$completedTasks/$totalTasks', style: TextStyle(color: AppColors.lightGray, fontSize: AppSizes.s0_75),)
      ],
    );
  }
}
