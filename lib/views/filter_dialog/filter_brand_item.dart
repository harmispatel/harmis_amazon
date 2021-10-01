import 'package:big_mart/models/brand_master.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';

class FilterBrandItemView extends StatelessWidget {
  BrandDetails brandDetails;

  FilterBrandItemView({this.brandDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CommonColors.white,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        border: Border.all(width: 1, color: brandDetails.isSelected ? Colors.orangeAccent.withOpacity(.9) : CommonColors.color_dddddd)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            brandDetails.name,
            style: CommonStyle.getAppFont(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.0,
                color: brandDetails.isSelected ? CommonColors.dark_6060 : CommonColors.color_515c6f),
          ),
          /*Text(
            " ( ${brandDetails.productCount} )",
            style: CommonStyle.getAppFont(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.0,
                color: CommonColors.color_96979d),
          ),*/
        ],
      ),
    );
  }
}
