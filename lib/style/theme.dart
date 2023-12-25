import 'package:flutter/material.dart';
import 'package:suitmedia_intern_test/style/color.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      fontFamily: "Poppins-SemiBold",
      height: 1.5
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: "Poppins-Medium",
      height: 1.5,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),

    bodyLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.5, //21
    ),
    bodySmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      height: 1.5, //15
    ),
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: MyColors.magenta
    ),
    actionsIconTheme: IconThemeData(
      color: MyColors.magenta
    )
  )
);