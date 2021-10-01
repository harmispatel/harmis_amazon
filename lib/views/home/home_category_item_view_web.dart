import 'package:big_mart/models/category.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';

class HomeCategoryItemViewWeb extends StatelessWidget {
  int position;
  CategoryDetails category;

  HomeCategoryItemViewWeb({this.position, this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
      height: 150,
      margin: EdgeInsets.only(right: 16, left: position == 0 ? 16 : 0),
      // padding: EdgeInsets.only(bottom: 0, left: 10),
      decoration: BoxDecoration(
          color: CommonUtils.isEmpty(category.color)
              ? CommonColors.primaryColor
              : CommonColors.colorFromHex(category.color),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 140,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                category.categoriesImg.toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 35,
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Text(
                category.categoriesSlug.toString(),
                overflow: TextOverflow.ellipsis,
                style: CommonStyle.getAppFont(
                    color: CommonColors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: Text(
                    category.categoriesSlug.toString(),
                    style: CommonStyle.getAppFont(
                        color: CommonColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                width: 80,
                child: Image.network(category.categoriesImg.toString()),
              )
            ],
          ),*/
        ],
      ),
    );
  }
}
