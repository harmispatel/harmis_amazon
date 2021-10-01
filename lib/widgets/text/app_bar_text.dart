import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:big_mart/utils/text_style.dart';

class AppBarText extends StatelessWidget {
  final String text;
  final Color fontColor;
  final double fontSize;
  final FontWeight fontWeight;
  final int maxLines;

  AppBarText(
      {@required this.text,
      this.fontColor,
      this.fontSize,
      this.fontWeight,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      style: CommonStyle.getAppFont(
          color: fontColor ?? Colors.white,
          fontSize: fontSize ?? 18.0,
          fontWeight: fontWeight ?? FontWeight.bold,),
    );
  }
}
