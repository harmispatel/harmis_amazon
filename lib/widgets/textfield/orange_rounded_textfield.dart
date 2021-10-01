import 'package:flutter/material.dart';
import 'package:big_mart/utils/common_colors.dart';

class OrangeRoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsureText;
  final TextInputType textInputType;
  final TextAlign textAlign;
  final TextInputAction textInputAction;
  final Function(String) onChanged;
  final Function(String) validator;
  final Function onFieldSubmitted;
  final FocusNode focusNode;
  final Widget prefixIcon, suffixIcon;
  final EdgeInsetsGeometry contentPadding;
  final int maxLines, maxLength;
  final TextStyle textStyle;

  OrangeRoundedTextField(
      {this.controller,
      this.hintText,
      this.obsureText,
      this.textInputType,
      this.textAlign,
      this.textInputAction,
      this.onChanged,
      this.validator,
      this.onFieldSubmitted,
      this.focusNode,
      this.prefixIcon,
      this.suffixIcon,
      this.contentPadding,
      this.maxLines,
      this.maxLength,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller ?? new TextEditingController(),
      focusNode: focusNode ?? FocusNode(),
      obscureText: obsureText ?? false,
      textAlign: textAlign ?? TextAlign.start,
      textInputAction: textInputAction ?? TextInputAction.done,
      onChanged: onChanged ?? (value) {},
      maxLines: maxLines ?? 1,
      maxLength: maxLength ?? 10000,
      autofocus: false,
      style: textStyle ??
          TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: CommonColors.primaryColor),
      keyboardType: textInputType ?? TextInputType.text,
      decoration: InputDecoration(
          contentPadding:
              contentPadding ?? EdgeInsets.only(left: 15.0, right: 15.0),
          hintText: hintText ?? "",
          counter: Container(
            height: 1,
            width: 1,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange, width: 0.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange, width: 0.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange, width: 0.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CommonColors.lightGrey, width: 0.5),
            borderRadius: BorderRadius.circular(10.0),
          )),
    );
  }
}
