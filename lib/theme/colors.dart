
import 'package:flutter/material.dart';

@immutable
abstract final class AppColors {
  // PRIMARY
  static Color get background => const Color(0xFF1A1A1A);
  static Color get accentGray => const Color(0xFF2A2A2A);
  static Color get green => const Color(0xFF6EDF60);
  static Color get lightGray => const Color(0xFFA8A8A8);
  static Color get grayInGray => const Color(0xFF323232);
  static Color get white => const Color(0xFFFFFFFF);
  static Color get black => const Color(0xFF000000);

  // SECONDARY
  static Color get greenGray => const Color(0xFF242315);
  static Color get blue => const Color(0xFFA3E5EE);
  static Color get red => const Color(0xFFF58A68);
  static Color get violet => const Color(0xFFC5C3EE);

  // MISC
  static Color get warning => const Color(0xFFB03C3F);
  static Color get success => const Color(0xFF1EAD1B);
}
