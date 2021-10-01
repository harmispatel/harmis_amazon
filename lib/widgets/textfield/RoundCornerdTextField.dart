import 'package:flutter/material.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/constant.dart';

class RoundCornerTextField extends StatelessWidget {
  final Color backgroundColor;
  final String buttonText;
  final String hintText;
  final Color textColor;
  final Color borderColor;
  final Function onChanged;
  bool isAllcaps = false;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double width;
  final double height;
  final double radious;
  final double borderWidth;
  final int maxLines;
  final TextAlign textAlign;
  final TextEditingController controller;
  final TextInputType inputType;
  final FormFieldValidator<String> validator;
  final bool autoFocus;
  final bool obscureText;
  final String suffixIcon;
  final Color hintTextColor;
  final bool enabled;

  RoundCornerTextField(
      {this.backgroundColor,
      this.buttonText,
      this.hintText,
      this.textColor,
      this.borderColor,
      this.onChanged,
      this.isAllcaps,
      this.margin,
      this.padding,
      this.width,
      this.height,
      this.radious,
      this.borderWidth,
      this.maxLines,
      this.textAlign,
      this.controller,
      this.inputType,
      this.validator,
      this.autoFocus,
      this.obscureText,
      this.suffixIcon,
      this.hintTextColor,
      this.enabled});

  @override
  Widget build(BuildContext context) {
    final suffixIconContainer = new Container(
      padding: EdgeInsets.all(15),
      height: 10, width: 10,
      child: Image.asset(
          suffixIcon == null ? "" : suffixIcon), // icon is 48px widget.
    );

    final textField = new TextFormField(
      maxLines: maxLines != null ? maxLines : 1,
      controller: controller,
      validator: validator,
      textAlign: textAlign != null ? textAlign : TextAlign.left,
      enabled: enabled == null ? true : enabled,
      autofocus: autoFocus == null ? false : autoFocus,
      keyboardType: inputType == null ? TextInputType.text : inputType,
      obscureText: obscureText == null ? false : obscureText,
      style: TextStyle(
          fontFamily: AppConstants.FONT_FAMILY,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: CommonColors.primaryColor),
      decoration: new InputDecoration(
        hintText: hintText != null ? hintText : "",
        hintStyle: TextStyle(color: CommonColors.lightGrey),
        suffixIcon: suffixIcon != null ? suffixIconContainer : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                color: borderColor == null
                    ? CommonColors.primaryColor
                    : borderColor)),
        contentPadding: padding == null ? EdgeInsets.all(12.0) : padding,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                color: borderColor == null
                    ? CommonColors.primaryColor
                    : borderColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                color: borderColor == null
                    ? CommonColors.primaryColor
                    : borderColor)),
      ),
    );

    final textFieldContainer = new Container(
      margin: margin,
      width: width != null ? width : MediaQuery.of(context).size.width,
      child: textField,
    );
    return textFieldContainer;
  }
}
