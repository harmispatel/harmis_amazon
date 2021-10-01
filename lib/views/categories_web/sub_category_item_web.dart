import 'package:big_mart/models/category.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';

class SubCategoryItemView extends StatelessWidget {
  CategoryDetails subCategory;

  SubCategoryItemView({this.subCategory});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CommonColors.white,
      padding: EdgeInsets.only(top: 5, bottom: 15, left: 2, right: 2),
      margin: EdgeInsets.only(left: 24, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subCategory.categoriesSlug,
            textAlign: TextAlign.end,
            style: CommonStyle.getAppFont(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: CommonColors.black),
          ),
          /* Container(
            margin: EdgeInsets.only(top: 16,),
            height: 1.5,
            color: CommonColors.color_dcdcdc,
          )*/
        ],
      ),
    );
  }
}
