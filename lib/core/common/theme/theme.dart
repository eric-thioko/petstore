import 'package:flutter/material.dart';
import 'package:petstore/core/common/theme/theme_colors.dart';
export 'theme_colors.dart';
export 'theme_text_style.dart';

final TextTheme textTheme = TextTheme(
  displayLarge: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 57,
    fontWeight: FontWeight.w400,
  ),
  displayMedium: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 45,
    fontWeight: FontWeight.w400,
  ),
  displaySmall: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 36,
    fontWeight: FontWeight.w400,
  ),
  headlineLarge: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 32,
    fontWeight: FontWeight.w400,
  ),
  headlineMedium: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 28,
    fontWeight: FontWeight.w400,
  ),
  headlineSmall: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.w400,
  ),
  titleLarge: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w500,
  ),
  titleMedium: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  titleSmall: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
  bodyLarge: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  bodyMedium: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  bodySmall: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),
  labelLarge: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
  labelMedium: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w500,
  ),
  labelSmall: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 11,
    fontWeight: FontWeight.w500,
  ),
);

final ThemeData lightTheme = ThemeData(
  fontFamily: "Poppins",
  platform: TargetPlatform.android,
  scaffoldBackgroundColor: ThemeColors.tertiaryBlack,
  useMaterial3: true, // Enables Material 3
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: ThemeColors.primaryOrange,
    brightness: Brightness.light,
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: ThemeColors.primaryWhite),
    backgroundColor: ThemeColors.transparent,
    foregroundColor: ThemeColors.primaryWhite,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: ThemeColors.primaryBlack,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: ThemeColors.primaryGray),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      backgroundColor: Color(0XFFF36100),
      foregroundColor: ThemeColors.primaryWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: ThemeColors.primaryOrange,
    selectionHandleColor: ThemeColors.primaryOrange,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: ThemeColors.primaryWhite,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    hintStyle: TextStyle(
      color: ThemeColors.primaryBlack.withValues(alpha: 0.5),
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
  ),
  textTheme: textTheme,
);

// final ThemeData darkTheme = ThemeData(
//   useMaterial3: true,
//   brightness: Brightness.dark,
//   colorScheme: ColorScheme.fromSeed(
//     seedColor: Colors.blue,
//     brightness: Brightness.dark,
//   ),
//   appBarTheme: const AppBarTheme(
//     backgroundColor: Colors.black,
//     foregroundColor: Colors.white,
//     elevation: 0,
//     titleTextStyle: TextStyle(
//       fontSize: 20,
//       fontWeight: FontWeight.bold,
//       color: Colors.white,
//     ),
//   ),
//   textButtonTheme: TextButtonThemeData(
//     style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: Colors.blueAccent,
//       foregroundColor: Colors.black,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//     ),
//   ),
//   inputDecorationTheme: InputDecorationTheme(
//     filled: true,
//     fillColor: Colors.grey[900],
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8),
//       borderSide: BorderSide.none,
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8),
//       borderSide: BorderSide.none,
//     ),
//     hintStyle: TextStyle(color: Colors.grey[400]),
//   ),
//   textTheme: textTheme,
// );
