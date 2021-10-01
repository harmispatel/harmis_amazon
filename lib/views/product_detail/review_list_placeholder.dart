import 'package:big_mart/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/text_style.dart';

class ReviewListPlaceHolderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 30, width: 30,
            child: Icon(
              Icons.message,
              color: CommonColors.color_515c6f,
            ),
          ),
          Flexible(
              child: Container(
                margin: EdgeInsets.only(left: 12),
                child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                S.of(context).noCustomerReviewYet,
                style: CommonStyle.getAppFont(
                    color: CommonColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                S.of(context).wouldYouLikeToWriteReview,
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
