import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';

@immutable
abstract final class AppThemes {
  static TextStyle headline = TextStyle(
    fontFamily: 'BoehringerForwardHead',
    fontSize: AppSizes.s2,
    fontWeight: AppThemes.medium.fontWeight,
  );

  static const TextStyle boehringer = TextStyle(
    fontFamily: 'BoehringerForwardText',
  );

  static const TextStyle body = TextStyle(fontSize: AppSizes.s1_5);

  // FONT WEIGHTS
  static const TextStyle regular = TextStyle(fontWeight: FontWeight.w400);
  static const TextStyle medium = TextStyle(fontWeight: FontWeight.w500);
  static const TextStyle bold = TextStyle(fontWeight: FontWeight.w700);

  // TEXT COLORS
  static TextStyle green = TextStyle(color: AppColors.green);
  static TextStyle white = TextStyle(color: AppColors.white);
  static TextStyle grey = TextStyle(color: AppColors.lightGray);
  static TextStyle success = TextStyle(color: AppColors.success);
  static TextStyle warning = TextStyle(color: AppColors.warning);

  // TEXT DECORATION
  static const TextStyle underlined =
      TextStyle(decoration: TextDecoration.underline);
  static const TextStyle italic = TextStyle(fontStyle: FontStyle.italic);

  // MATERIAL
  // static ElevatedButtonThemeData elevatedButton = ElevatedButtonThemeData(
  //   style: ButtonStyle(
  //     backgroundColor: MaterialStateProperty.resolveWith((states) {
  //       if (states.contains(MaterialState.disabled)) {
  //         return AppColors.accentGreen.withOpacity(0.5);
  //       }
  //       return AppColors.accentGreen;
  //     }),
  //     textStyle: MaterialStateProperty.resolveWith((states) {
  //       if (states.contains(MaterialState.disabled)) {
  //         return AppThemes.boehringer
  //             .merge(TextStyle(color: AppColors.darkGreen.withOpacity(0.5)));
  //       }
  //       return AppThemes.bold.merge(AppThemes.boehringer);
  //     }),
  //     padding: MaterialStateProperty.all(
  //       const EdgeInsets.symmetric(
  //         horizontal: AppSizes.s1_5,
  //         vertical: AppSizes.s0_75,
  //       ),
  //     ),
  //     shape: MaterialStateProperty.all(
  //       RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(AppSizes.s0_125),
  //       ),
  //     ),
  //     elevation: MaterialStateProperty.all(0),
  //   ),
  // );

  static OutlinedButtonThemeData outlinedButton = OutlinedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(
          horizontal: AppSizes.s1_5,
          vertical: AppSizes.s0_75,
        ),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s0_125),
        ),
      ),
      textStyle:
          MaterialStateProperty.all(AppThemes.bold.merge(AppThemes.boehringer)),
    ),
  );

  // static InputDecorationTheme inputDecoration = InputDecorationTheme(
  //   border: OutlineInputBorder(
  //     borderRadius: const BorderRadius.all(
  //       Radius.circular(AppSizes.s0_125),
  //     ),
  //     borderSide: BorderSide(
  //       color: AppColors.neutralGray,
  //     ),
  //   ),
  //   focusedBorder: OutlineInputBorder(
  //     borderRadius: const BorderRadius.all(
  //       Radius.circular(AppSizes.s0_125),
  //     ),
  //     borderSide: BorderSide(
  //       color: AppColors.neutralGray,
  //       width: AppSizes.s0_125,
  //     ),
  //   ),
  // );

  static DatePickerThemeData datePicker = DatePickerThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.s0_125),
    ),
  );

  static AppBarTheme appBar = AppBarTheme(
    backgroundColor: AppColors.background,
    iconTheme: IconThemeData(color: AppColors.white),
  );

  static CardTheme card = CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.s0_125),
    ),
  );

  // static DialogTheme dialog = DialogTheme(
  //   shape: RoundedRectangleBorder(
  //     side: BorderSide(color: AppColors.neutralGray),
  //     borderRadius: BorderRadius.circular(AppSizes.s0_125),
  //   ),
  // );
}
