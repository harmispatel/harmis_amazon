import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/category.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';

class FilterCategoryItemView extends StatelessWidget {
  CategoryDetails categoryDetails;

  FilterCategoryItemView({this.categoryDetails});

  @override
  Widget build(BuildContext context) {
    final divider = Container(
      color: CommonColors.color_dcdcdc,
      height: 1,
    );
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          divider,
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  categoryDetails.categoriesSlug.toString(),
                  style: CommonStyle.getAppFont(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: CommonColors.color_515c6f),
                ),
                categoryDetails.isSelected ? Icon(Icons.done, color: CommonColors.primaryColor,) : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
