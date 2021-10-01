import 'package:big_mart/models/category.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';

class CategoryItemView extends StatelessWidget {
  CategoryDetails category;

  CategoryItemView({this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: category.isSelected ? CommonColors.white : CommonColors.color_f3f3f3,
      padding: EdgeInsets.only(top: 16, left: 2, right: 2),
      child: Column(
        children: [
          Text(
            category.categoriesSlug.toString(),
            textAlign: TextAlign.center,
            style: CommonStyle.getAppFont(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: CommonColors.color_515c6f),
          ),
          Container(
            margin: EdgeInsets.only(top: 16, left: 8, right: 8),
            height: 1.5,
            color: category.isSelected ? Colors.transparent : CommonColors.color_dcdcdc,
          )
        ],
      ),
    );
  }
}
