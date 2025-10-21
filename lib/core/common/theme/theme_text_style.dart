import 'package:flutter/material.dart';
import 'package:petstore/core/common/theme/theme_colors.dart';

class ThemeTextStyle {
  //Font Family
  static TextStyle poppins = TextStyle(
    fontFamily: "Poppins",
    color: ThemeColors.primaryBlack,
  );

  //Font Size
  static TextStyle fs8 = TextStyle(fontSize: 8).merge(poppins);
  static TextStyle fs10 = TextStyle(fontSize: 10).merge(poppins);
  static TextStyle fs11 = TextStyle(fontSize: 11).merge(poppins);
  static TextStyle fs12 = TextStyle(fontSize: 12).merge(poppins);
  static TextStyle fs13 = TextStyle(fontSize: 13).merge(poppins);
  static TextStyle fs14 = TextStyle(fontSize: 14).merge(poppins);
  static TextStyle fs16 = TextStyle(fontSize: 16).merge(poppins);
  static TextStyle fs18 = TextStyle(fontSize: 18).merge(poppins);
  static TextStyle fs20 = TextStyle(fontSize: 20).merge(poppins);
  static TextStyle fs22 = TextStyle(fontSize: 22).merge(poppins);
  static TextStyle fs24 = TextStyle(fontSize: 24).merge(poppins);
  static TextStyle fs28 = TextStyle(fontSize: 28).merge(poppins);
  static TextStyle fs32 = TextStyle(fontSize: 32).merge(poppins);
  static TextStyle fs36 = TextStyle(fontSize: 36).merge(poppins);
  static TextStyle fs40 = TextStyle(fontSize: 40).merge(poppins);
  static TextStyle fs48 = TextStyle(fontSize: 48).merge(poppins);
  static TextStyle fs56 = TextStyle(fontSize: 56).merge(poppins);
  static TextStyle fs64 = TextStyle(fontSize: 64).merge(poppins);
  static TextStyle fs72 = TextStyle(fontSize: 72).merge(poppins);
  static TextStyle fs80 = TextStyle(fontSize: 80).merge(poppins);
  static TextStyle fs88 = TextStyle(fontSize: 88).merge(poppins);
  static TextStyle fs96 = TextStyle(fontSize: 96).merge(poppins);

  // Font Weight
  static TextStyle extraBold = const TextStyle(fontWeight: FontWeight.w800);
  static TextStyle bold = const TextStyle(fontWeight: FontWeight.bold);
  static TextStyle semibold = const TextStyle(fontWeight: FontWeight.w600);
  static TextStyle medium = const TextStyle(fontWeight: FontWeight.w500);
  static TextStyle regular = const TextStyle(fontWeight: FontWeight.w400);
  static TextStyle light = const TextStyle(fontWeight: FontWeight.w300);
}
