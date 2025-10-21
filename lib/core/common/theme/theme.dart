import 'package:flutter/material.dart';
import 'package:petstore/core/common/theme/theme_colors.dart';
export 'theme_colors.dart';
export 'theme_text_style.dart';

final TextTheme textTheme = TextTheme(
  displayLarge: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 57,
    fontWeight: FontWeight.w400,
    color: ThemeColors.primaryWhite,
  ),
  displayMedium: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 45,
    fontWeight: FontWeight.w400,
    color: ThemeColors.primaryWhite,
  ),
  displaySmall: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 36,
    fontWeight: FontWeight.w400,
    color: ThemeColors.primaryWhite,
  ),
  headlineLarge: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: ThemeColors.primaryWhite,
  ),
  headlineMedium: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 28,
    fontWeight: FontWeight.w400,
    color: ThemeColors.primaryWhite,
  ),
  headlineSmall: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: ThemeColors.primaryWhite,
  ),
  titleLarge: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: ThemeColors.primaryWhite,
  ),
  titleMedium: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ThemeColors.primaryWhite,
  ),
  titleSmall: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ThemeColors.primaryWhite,
  ),
  bodyLarge: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ThemeColors.primaryWhite,
  ),
  bodyMedium: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ThemeColors.primaryWhite,
  ),
  bodySmall: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ThemeColors.primaryWhite,
  ),
  labelLarge: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ThemeColors.primaryWhite,
  ),
  labelMedium: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: ThemeColors.primaryWhite,
  ),
  labelSmall: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: ThemeColors.primaryWhite,
  ),
);

final ThemeData theme = ThemeData(
  fontFamily: "Poppins",
  platform: TargetPlatform.android,
  scaffoldBackgroundColor: ThemeColors.tertiaryBlack,
  useMaterial3: true, // Enables Material 3
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: ThemeColors.primaryOrange,
    brightness: Brightness.light,
    onSurface: ThemeColors.primaryBlack,
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: ThemeColors.primaryWhite),
    backgroundColor: ThemeColors.transparent,
    foregroundColor: ThemeColors.primaryWhite,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: ThemeColors.primaryWhite,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: ThemeColors.primaryWhite),
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
    labelStyle: TextStyle(
      color: ThemeColors.primaryBlack,
      fontFamily: "Poppins",
    ),
    hintStyle: TextStyle(
      color: ThemeColors.primaryGray,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    floatingLabelStyle: TextStyle(
      color: ThemeColors.primaryBlack,
      fontFamily: "Poppins",
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    textStyle: TextStyle(
      color: ThemeColors.primaryBlack,
      fontFamily: "Poppins",
    ),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(ThemeColors.primaryWhite),
    ),
  ),
  menuTheme: MenuThemeData(
    style: MenuStyle(
      backgroundColor: WidgetStateProperty.all(ThemeColors.primaryWhite),
    ),
  ),
  menuButtonTheme: MenuButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(ThemeColors.primaryBlack),
      textStyle: WidgetStateProperty.all(
        TextStyle(color: ThemeColors.primaryBlack, fontFamily: "Poppins"),
      ),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(foregroundColor: ThemeColors.primaryOrange),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: ThemeColors.primaryOrange,
    foregroundColor: ThemeColors.primaryWhite,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: ThemeColors.primaryOrange,
    surfaceTintColor: Colors.transparent,
    labelStyle: TextStyle(
      color: ThemeColors.primaryWhite,
      fontFamily: "Poppins",
    ),
    deleteIconColor: ThemeColors.primaryWhite,
    side: BorderSide.none,
    elevation: 0,
    shadowColor: Colors.transparent,
    selectedColor: ThemeColors.primaryOrange,
    disabledColor: ThemeColors.primaryOrange.withValues(alpha:0.5),
    brightness: Brightness.dark,
  ),
  dialogTheme: DialogThemeData(
    backgroundColor: ThemeColors.primaryBlack,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: TextStyle(
      color: ThemeColors.primaryWhite,
      fontFamily: "Poppins",
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    contentTextStyle: TextStyle(
      color: ThemeColors.primaryWhite,
      fontFamily: "Poppins",
      fontSize: 16,
    ),
  ),
  textTheme: textTheme,
);

