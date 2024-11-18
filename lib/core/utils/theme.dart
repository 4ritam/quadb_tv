import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF1E1E1E);
  static const Color secondaryColor = Color(0xFF2C2C2C);
  static const Color accentColor = Color(0xFFE50914);
  static const Color textColor = Color(0xFFFFFFFF);

  // Text Styles
  static TextStyle get headingStyle => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: textColor,
      );

  static TextStyle get titleStyle => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: textColor,
      );

  static TextStyle get bodyStyle => TextStyle(
        fontSize: 14.sp,
        color: textColor,
      );

  static TextStyle get subtitleStyle => TextStyle(
        fontSize: 16.sp,
        color: textColor.withOpacity(0.7),
      );

  // Spacing
  static double get defaultPadding => 16.w;
  static double get smallPadding => 8.w;
  static double get largePadding => 24.w;

  // Border Radius
  static double get defaultRadius => 8.r;
  static double get largeRadius => 16.r;

  // Theme Data
  static ThemeData get theme => ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: primaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 0,
          titleTextStyle: titleStyle,
          toolbarHeight: kToolbarHeight.h,
        ),
        textTheme: TextTheme(
          headlineMedium: headingStyle,
          titleMedium: titleStyle,
          bodyMedium: bodyStyle,
          titleSmall: subtitleStyle,
        ),
        colorScheme: const ColorScheme.dark(
          primary: accentColor,
          secondary: secondaryColor,
        ),
      );
}
