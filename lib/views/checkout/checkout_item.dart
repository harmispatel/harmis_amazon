import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/cart_master.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';

class CheckoutItemView extends StatelessWidget {
  CartDetails cartDetails;

  CheckoutItemView({this.cartDetails});

  @override
  Widget build(BuildContext context) {

    final ivProductImage = Container(
      height: 75,
      width: 60,
      margin: EdgeInsets.only(top: 8, left: 12),
      color: Colors.grey,
      child: Image.network(
        cartDetails.productsImage.toString(),
        fit: BoxFit.fill,
      ),
    );

    final tvProductName = Container(
      margin: EdgeInsets.only(top: 8),
      child: Text(
        cartDetails.productName.toString(),
        // "V Neck Shirt - Pink",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: CommonStyle.getAppFont(
            color: CommonColors.color_515c6f,
            fontSize: 15,
            fontWeight: FontWeight.w400),
      ),
    );

    final layoutProductPrice = Container(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Text(
            cartDetails.productPrice.toString(),
            // "\$24.99",
            style: CommonStyle.getAppFont(
                color: CommonColors.primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w700),
          ),
          Flexible(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Text(
                      "IQ",
                      style: CommonStyle.getAppFont(
                          color: CommonColors.color_515c6f,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "/ " + S.of(context).piece,
                      style: CommonStyle.getAppFont(
                          color: CommonColors.color_96979d,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ))
        ],
      ),
    );

    final tvDescountPrice = Padding(
      padding: EdgeInsets.only(top: 4),
      child: Text(
        cartDetails.productFinalPrice.toString() + " IQ",
        // "65.00 IQ",
        style: CommonStyle.getAppFont(
            color: CommonColors.color_96979d,
            fontSize: 12,
            decoration: TextDecoration.lineThrough,
            fontWeight: FontWeight.w400),
      ),
    );

    return Container(
      margin: EdgeInsets.only(right: 12, left: 12, top: 12),
      padding: EdgeInsets.only(bottom: 12, left: 10, top: 8, right: 10),
      decoration: BoxDecoration(
          color: CommonColors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ivProductImage,
          Flexible(
              child: Container(
                margin: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    tvProductName,
                    layoutProductPrice,
                    tvDescountPrice,
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
