import 'package:big_mart/models/product_details.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/text_style.dart';

class ReviewListItemView extends StatelessWidget {
  int position;
  Review review;

  ReviewListItemView({this.position, this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: position == 0 ? 0 : 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 30, width: 30,
            // child: ClipRRect(
            //   borderRadius: BorderRadius.all(Radius.circular(15)),
            //   child: Image.network(review.customerPicture.toString()),
            // ),
            child: Icon(
              Icons.message,
              color: CommonColors.color_515c6f,
            ),
          ),
          Flexible(
              child: Container(
            margin: EdgeInsets.only(left: 12,right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  review.customerName.toString(),
                  style: CommonStyle.getAppFont(
                      color: CommonColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  review.reviewText.toString(),
                  style: CommonStyle.getAppFont(
                      color: CommonColors.color_515c6f,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
