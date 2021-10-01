import 'package:flutter/material.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/text_style.dart';

class RoundWhiteTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsureText;
  final TextInputType textInputType;
  final TextAlign textAlign;
  final TextInputAction textInputAction;
  final Function(String) onChanged;
  final Function(String) validator;
  final Function onFieldSubmitted;
  final Widget prefixIcon, suffixIcon;
  final EdgeInsetsGeometry contentPadding;
  final int maxLines, maxLength;
  final TextStyle textStyle;
  final bool enabled;
  final double height;

  RoundWhiteTextField(
      {this.controller,
      this.hintText,
      this.obsureText,
      this.textInputType,
      this.textAlign,
      this.textInputAction,
      this.onChanged,
      this.validator,
      this.onFieldSubmitted,
      this.prefixIcon,
      this.suffixIcon,
      this.contentPadding,
      this.maxLines,
      this.maxLength,
      this.textStyle,
      this.enabled,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height ?? 40.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: TextField(
        controller: controller ?? new TextEditingController(),
        obscureText: obsureText ?? false,
        textAlign: textAlign ?? TextAlign.start,
        textInputAction: textInputAction ?? TextInputAction.done,
        onChanged: onChanged ?? (value) {},
        maxLines: maxLines ?? 1,
        maxLength: maxLength ?? 10000,
        enabled: enabled ?? true,
        autofocus: false,
        style: textStyle ??
            CommonStyle.getAppFont(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: CommonColors.primaryColor),
        keyboardType: textInputType ?? TextInputType.text,
        decoration: InputDecoration(
            contentPadding: contentPadding ??
                EdgeInsets.only(left: 15.0, right: 15.0, bottom: 8.0),
            hintText: hintText ?? "",
            hintStyle: CommonStyle.getAppFont(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: CommonColors.color_9f9f9f),
            counter: Container(
              height: 1,
              width: 1,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: InputBorder.none),
      ),
    );
  }
}
