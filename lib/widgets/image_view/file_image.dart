import 'dart:io';

import 'package:flutter/material.dart';

class FileImageView extends StatelessWidget {
  final double height, width;
  final imagePath;
  final BoxFit boxFit;
  final bool isCircule;

  FileImageView(
      {this.height, this.width, this.imagePath, this.boxFit, this.isCircule});

  @override
  Widget build(BuildContext context) {
    File file = new File(imagePath);

    final roundedImage = ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      clipBehavior: Clip.antiAlias,
      child: Image.file(
        file,
        height: height ?? 50,
        width: width ?? 50,
        fit: boxFit ?? BoxFit.cover,
      ),
    );

    final circuleImage = ClipOval(
        clipBehavior: Clip.antiAlias,
        child: Image.file(
          file,
          height: height ?? 50,
          width: width ?? 50,
          fit: boxFit ?? BoxFit.cover,
        ));

    if (isCircule != null) {
      if (isCircule) {
        return circuleImage;
      } else {
        return roundedImage;
      }
    } else {
      return roundedImage;
    }

  }
}
