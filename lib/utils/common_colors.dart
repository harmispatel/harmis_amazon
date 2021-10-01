import 'dart:ui';

import 'package:flutter/material.dart';

class CommonColors {
  /*static const primaryColor = Color(0xFF0D7F41);
  static const primaryDarkColor = Color(0xFF0D7F41);*/
  static const primaryColor = Color(0xFF1D2B47);
  static const primaryDarkColor = Color(0xFF1D2B47);
  static const primaryAppBackground = Color(0xFFf3f4f6);
  static const primaryWhite = Colors.white;
  static const primaryBlack = Colors.black;
  static const primaryLight = Color(0xFFF6FFFA);
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const red = Color(0xFFFF0000);

  static var lightGrey = Color(0x75969696);
  static var color_c4c4c4 = Color(0xFFC4C4C4);
  static var color_9f9f9f = Color(0xFF9F9F9F);
  static var color_515c6f = Color(0xFF515C6F);
  static var color_4a9b6f = Color(0xFF4A9B6F);
  static var color_f1e795 = Color(0xFFF1E795);
  static var color_96979d = Color(0xFF96979D);
  static var color_f3f3f3 = Color(0xFFF3F3F3);
  static var color_dcdcdc = Color(0xFFDCDCDC);
  static var color_dddddd = Color(0xFFDDDDDD);
  static var color_707070 = Color(0xFF686767);
  static var dark_grey = Color(0xFF282525);
  static var dark_blue = Color(0xFF2D4471);
  static var dark_6060 = Color(0xFF1D2B47);
  static var darkk = Color(0xFFF9F9FC);
  static var color_8080 = Color(0xFF3C4D61);
  static var blue_3c = Color(0xFF3C4D61);
  static var black_23 = Color(0xFF232F3E);
  static var orange_f8 = Color(0xFFF8922E);
  final Color color = CommonColors.lightGrey;

  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
