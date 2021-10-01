import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonStyle {
  static TextStyle getAppFont(
      {Color color,
      double fontSize,
      FontWeight fontWeight,
      FontStyle fontStyle,
      TextDecoration decoration,
      double height,
      double letterSpacing}) {
    /*return TextStyle(
      fontFamily: "Montserrat",
      color: color,
      letterSpacing: letterSpacing == null ? 0.3 : letterSpacing,
      decoration: decoration != null ? decoration : TextDecoration.none,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle == null ? FontStyle.normal : fontStyle,
      height: height,
    );*/
    return GoogleFonts.roboto(
      textStyle: TextStyle(
          color: color,
          letterSpacing: letterSpacing == null ? 0.3 : letterSpacing,
          decoration: decoration != null ? decoration : TextDecoration.none),
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle == null ? FontStyle.normal : fontStyle,
      height: height,
    );
  }
}
