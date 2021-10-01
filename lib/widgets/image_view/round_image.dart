import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/local_images.dart';

class RoundImageView extends StatelessWidget {
  final double height, width, radious;
  final BoxFit fit;
  final String imageUrl;
  final Color borderColor;
  final double borderWidth;

  RoundImageView(
      {this.height,
      this.width,
      this.imageUrl,
      this.radious,
      this.fit,
      this.borderColor,
      this.borderWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radious ?? 0.0),
          boxShadow: [
            BoxShadow(color: CommonColors.lightGrey, offset: Offset.zero)
          ],
          border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderWidth ?? 0.0)),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(radious ?? 2),
        child: FadeInImage(
            height: height ?? 50,
            width: width ?? 50,
            fit: fit ?? BoxFit.cover,
            placeholder: AssetImage(LocalImages.logo),
            image: imageUrl.startsWith("http")
                ? NetworkImage(imageUrl)
                : AssetImage(LocalImages.logo)),
      ),
    );
    ;
  }
}
