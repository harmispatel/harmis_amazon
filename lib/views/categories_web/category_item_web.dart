import 'package:big_mart/models/category.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';

class CategoryItemViewWeb extends StatelessWidget {
  CategoryDetails category;

  CategoryItemViewWeb({this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CommonColors.white,
      // category.isSelected ? CommonColors.white : CommonColors.color_f3f3f3,
      padding: EdgeInsets.only(top: 5, left: 2, right: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category.categoriesSlug.toString(),
            textAlign: TextAlign.start,
            style: CommonStyle.getAppFont(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: CommonColors.black),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 8, right: 8),
            height: 0.8,
            color: category.isSelected
                ? Colors.transparent
                : CommonColors.color_dcdcdc,
          )
        ],
      ),
    );
  }
}
