import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/my_button.dart';

class FooterButtons extends StatelessWidget {
  const FooterButtons(
      {super.key, required this.onPressedAdd, required this.isShoped, this.completeShopping});

  final VoidCallback onPressedAdd;
  final bool isShoped;
  final VoidCallback? completeShopping;

  static const IconData add = IconData(0xe047, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.s1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: AppSizes.s10,
            height: AppSizes.s3,
            child: isShoped
                ? MyButton(
                    text: 'EINKAUFEN',
                    color: AppColors.green,
                    backgroundColor: Colors.transparent,
                    onPressed: completeShopping!,
                  )
                : null,
          ),
          SizedBox(
            width: AppSizes.s10,
            height: AppSizes.s3,
            child: MyButton(
                    text: 'HINZUFÜGEN',
                    color: AppColors.green,
                    backgroundColor: AppColors.accentGray,
                    onPressed: onPressedAdd,
                    icon: Icon(
                      add,
                      color: AppColors.green,
                    ),
                  )
          ),
        ],
      ),
    );
  }
}
