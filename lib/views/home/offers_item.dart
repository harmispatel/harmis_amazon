import 'package:big_mart/models/product_master.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/text_style.dart';

class OffersItemView extends StatelessWidget {
  int position;
  ProductData productData;

  OffersItemView({this.position, this.productData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: 100,
      margin: EdgeInsets.only(right: 16, left: position == 0 ? 16 : 0),
      padding: EdgeInsets.only(bottom: 0, left: 10),
      decoration: BoxDecoration(
          color: CommonColors.primaryColor,
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: Text(
                    productData.productName.toString(),
                    style: CommonStyle.getAppFont(
                        color: CommonColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                width: 80,
                child: Image.network(productData.productsImage.toString()),
              )
            ],
          ),
        ],
      ),
    );
  }
}
