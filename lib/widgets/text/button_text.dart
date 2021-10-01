import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:big_mart/utils/text_style.dart';

class ButtonText extends StatelessWidget {
  final String text;
  final Color fontColor;
  final double fontSize;
  final FontWeight fontWeight;

  ButtonText({@required this.text, this.fontColor, this.fontSize, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: CommonStyle.getAppFont(
          color: fontColor ?? Colors.white,
          fontSize: fontSize ?? 18.0,
          fontWeight: fontWeight ?? FontWeight.w600,),
    );
  }
}
