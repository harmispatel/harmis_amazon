import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/order_master.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/my_orders/order_product_item.dart';
import 'package:flutter/material.dart';

import '../../utils/common_utils.dart';

class OrderItemView extends StatelessWidget {
  OrderDetails orderDetails;
  Function onTrackPressed;

  OrderItemView({this.orderDetails, this.onTrackPressed});

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 8, right: 8, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // widget.productData.productName.toString(),
                  "#" + orderDetails.orderId.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CommonStyle.getAppFont(
                      color: CommonColors.color_515c6f,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  // widget.productData.productName.toString(),
                  orderDetails.purchaseDate.toString(),
                  // "dbfisjnfjndg",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CommonStyle.getAppFont(
                      color: CommonColors.color_515c6f,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        /*  orderDetails.product != null && orderDetails.product.length > 0
              ? */ListView.builder(
                  padding: EdgeInsets.only(top: 0, bottom: 0),
                  shrinkWrap: true,
                  itemCount: orderDetails.product.length,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext ctxt, int index) {
                    /*Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: Duration(seconds: 1),
                            pageBuilder: (_, __, ___) => ProductDetailsView()));*/
                    return OrderProductItemView(
                      product: orderDetails.product[index],
                    );
                  }),
             /* : Container(),*/
          Container(
            margin: EdgeInsets.only(top: 20, left: 20,right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  S.of(context).status +
                      ": " +
                      CommonUtils.getStatus(orderDetails.status, context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CommonStyle.getAppFont(
                      color: CommonColors.color_515c6f,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                onTrackPressed();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.orangeAccent.withOpacity(.9),
                    borderRadius: BorderRadius.circular(5.0)),
                padding: EdgeInsets.only(
                    top: 5.0, left: 5.0, bottom: 5.0, right: 5.0),
                child: Text(
                  S.of(context).trackOrder,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CommonStyle.getAppFont(
                      color: CommonColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
