import 'package:big_mart/models/product_master.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/text_style.dart';

class DealsItemView extends StatelessWidget {
  int position;
  ProductData productData;

  DealsItemView({this.position, this.productData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      height: 100,
      margin: EdgeInsets.only(right: 16, left: position == 0 ? 16 : 0),
      decoration: BoxDecoration(
          color: CommonColors.lightGrey,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(image: NetworkImage(productData.productsImage.toString(),)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width / 2,
            child: Text(
              productData.productName.toString(),
              style: CommonStyle.getAppFont(
                  color: CommonColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),

    );
  }
}
