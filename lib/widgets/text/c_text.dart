import 'package:flutter/material.dart';
import 'package:big_mart/utils/text_style.dart';

class CText extends StatelessWidget {
  final String text;
  final Color fontColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextOverflow textOverflow;
  final int maxLines;
  final TextDecoration textDecoration;

  CText(
      {@required this.text,
      this.textDecoration,
      this.fontColor,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.textOverflow,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      textAlign: textAlign ?? TextAlign.start,
      overflow: textOverflow ?? TextOverflow.ellipsis,
      style: CommonStyle.getAppFont(
        color: fontColor ?? Colors.black,
        fontSize: fontSize ?? 14.0,
        decoration: textDecoration ?? TextDecoration.none,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
