import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CirculeImageView extends StatelessWidget {
  final double height, width, borderWidth;
  final Color borderColor;
  final String imageUrl;
  CirculeImageView(
      {this.height,
      this.width,
      this.imageUrl,
      this.borderWidth,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderWidth ?? 1)),
      child: ClipOval(
        clipBehavior: Clip.antiAlias,
        child: Image.network(
          imageUrl ??
              "https://i.ya-webdesign.com/images/default-image-png-4.png",
          height: height ?? 50,
          width: width ?? 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
