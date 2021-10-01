import 'package:flutter/material.dart';
import 'package:big_mart/utils/common_colors.dart';

class ButtonBack extends StatelessWidget {
  BuildContext buildContext;
  Function onPress;

  ButtonBack({this.buildContext, this.onPress});

  @override
  Widget build(BuildContext context) {
    double appbarHeight = AppBar().preferredSize.height;
    return InkWell(
      onTap: onPress ??
          () {
            Navigator.pop(buildContext);
          },
      child: Icon(
        Icons.arrow_back,
        size: 25,
        color: CommonColors.primaryColor,
      ),
    );
  }
}
