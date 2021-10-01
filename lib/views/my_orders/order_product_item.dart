import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/order_master.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';

class OrderProductItemView extends StatelessWidget {
  OrderProduct product;

  OrderProductItemView({this.product});

  @override
  Widget build(BuildContext context) {
    final ivProductImage = Container(
      height: 75 / 2,
      width: 60 / 2,
      margin: EdgeInsets.only(top: 12, left: 12),
      color: Colors.grey,
      child: Image.network(
        product.image.toString(),
        fit: BoxFit.fill,
      ),
    );

    final tvProductName = Container(
      margin: EdgeInsets.only(top: 8),
      child: Text(
        // widget.productData.productName.toString(),
        product.productName.toString(),
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
            product.productPrice.toString(),
            // "\$20.50",
            style: CommonStyle.getAppFont(
                color: CommonColors.dark_6060,
                fontSize: 15,
                fontWeight: FontWeight.w700),
          ),
          Flexible(
              child: Row(
            children: [
             /* Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  "IQ",
                  style: CommonStyle.getAppFont(
                      color: CommonColors.color_515c6f,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),*/
             /* Flexible(
                child: Text(
                  "/ " + S.of(context).piece,
                  style: CommonStyle.getAppFont(
                      color: CommonColors.color_96979d,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              )*/
            ],
          ))
        ],
      ),
    );

    final orderProductItem = Row(
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
            ],
          ),
        ))
      ],
    );
    return orderProductItem;
  }
}
