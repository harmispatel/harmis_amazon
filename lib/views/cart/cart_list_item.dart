import 'package:big_mart/models/cart_master.dart';
import 'package:big_mart/models/product_master.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:provider/provider.dart';

import 'cart_list_item_view_model.dart';

class CartListItemView extends StatefulWidget {
  int position;
  CartDetails cartDetails;
  Function onAddQuantity, onRemoveQuantity, onDelete;

  CartListItemView({
    this.position,
    this.cartDetails,
    this.onAddQuantity,
    this.onRemoveQuantity,
    this.onDelete,
  });

  @override
  _CartListItemViewState createState() => _CartListItemViewState();
}

class _CartListItemViewState extends State<CartListItemView> {
  CartListItemViewModel mViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<CartListItemViewModel>(context, listen: false);
      mViewModel.attachContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<CartListItemViewModel>(context);

    final ivProductImage = Container(
      height: 65,
      width: 60,
      margin: EdgeInsets.only(top: 12, left: 12),
      color: Colors.grey,
      child: Image.network(
        widget.cartDetails.productsImage.toString(),
        fit: BoxFit.fill,
      ),
    );

    // final tvProductName = Container(
    //   margin: EdgeInsets.only(top: 8),
    //   child: Text(
    //     widget.cartDetails.productName.toString(),
    //     // "V Neck Shirt - Pink",
    //     maxLines: 2,
    //     overflow: TextOverflow.ellipsis,
    //     style: CommonStyle.getAppFont(
    //         color: CommonColors.black,
    //         fontSize: 15,
    //         fontWeight: FontWeight.bold),
    //   ),
    // );

    final tvProductName = Container(
      margin: EdgeInsets.only(top: 8),
      child: Text(widget.cartDetails.productName.toString(),
              maxLines: 2,
              style: CommonStyle.getAppFont(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),),

    );
    // final layoutProductPrice = Container(
    //   padding: EdgeInsets.only(top: 8),
    //   child: Row(
    //     children: [
    //       Text(
    //         widget.cartDetails.productPrice.toString(),
    //         // "\$24.99",
    //         style: CommonStyle.getAppFont(
    //             color: CommonColors.primaryColor,
    //             fontSize: 15,
    //             fontWeight: FontWeight.w700),
    //       ),
    //       Flexible(
    //           child: Row(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.only(left: 2),
    //             child: Text(
    //               "IQ",
    //               style: CommonStyle.getAppFont(
    //                   color: CommonColors.color_515c6f,
    //                   fontSize: 12,
    //                   fontWeight: FontWeight.w400),
    //             ),
    //           ),
    //           Flexible(
    //             child: Text(
    //               "/ " + S.of(context).piece,
    //               style: CommonStyle.getAppFont(
    //                   color: CommonColors.color_96979d,
    //                   fontSize: 12,
    //                   fontWeight: FontWeight.w400),
    //             ),
    //           )
    //         ],
    //       ))
    //     ],
    //   ),
    // );

    final layoutProductPrice = Container(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Text("\$" +
            widget.cartDetails.productPrice.toString(),
            // "\$24.99",
            style: TextStyle(
                color: CommonColors.color_8080,
                fontSize: 18,
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );


    final tvDescountPrice = Padding(
      padding: EdgeInsets.only(top: 4),
      child: Text(
        widget.cartDetails.productOriginalPrice.toString() + " IQ",
        // "65.00 IQ",
        style: CommonStyle.getAppFont(
            color: CommonColors.color_96979d,
            fontSize: 12,
            decoration: TextDecoration.lineThrough,
            fontWeight: FontWeight.w400),
      ),
    );

    // final layoutAddRemoveQuantity = Container(
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     children: [
    //       InkWell(
    //         onTap: (){
    //           print("Remove quantity");
    //           if (widget.cartDetails.customerBasketQuantity > 1) {
    //             widget.onRemoveQuantity();
    //           } else {
    //             widget.onDelete();
    //           }
    //         },
    //         child: Container(
    //           height: 25,
    //           width: 25,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.all(Radius.circular(5)),
    //             border: Border.all(color: CommonColors.primaryColor, width: 0.8),
    //             color: CommonColors.white
    //           ),
    //           child: Center(
    //             child: Text(
    //               "-",
    //               style: CommonStyle.getAppFont(
    //                   color: CommonColors.color_707070,
    //                   fontSize: 12,
    //                   fontWeight: FontWeight.w500),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Container(
    //         margin: EdgeInsets.only(left: 10, right: 10),
    //         child: Text(
    //           widget.cartDetails.customerBasketQuantity.toString(),
    //           style: CommonStyle.getAppFont(
    //               color: CommonColors.color_707070,
    //               fontSize: 12,
    //               fontWeight: FontWeight.w500),
    //         ),
    //       ),
    //       InkWell(
    //         onTap: (){
    //           print("Add quantity");
    //           widget.onAddQuantity();
    //         },
    //         child: Container(
    //           height: 25,
    //           width: 25,
    //           decoration: BoxDecoration(
    //               borderRadius: BorderRadius.all(Radius.circular(5)),
    //               border: Border.all(color: CommonColors.primaryColor, width: 0.8),
    //               color: CommonColors.white
    //           ),
    //           child: Center(
    //             child: Text(
    //               "+",
    //               style: CommonStyle.getAppFont(
    //                   color: CommonColors.color_707070,
    //                   fontSize: 12,
    //                   fontWeight: FontWeight.w500),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    final layoutAddRemoveQuantity = Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 17),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                print("Add quantity");
                widget.onAddQuantity();
              },
              child: Text(
                "+",
                style: CommonStyle.getAppFont(
                    color: CommonColors.color_707070,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 6,),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                widget.cartDetails.customerBasketQuantity.toString(),
                style: CommonStyle.getAppFont(
                    color: CommonColors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 5,),
            InkWell(
              onTap: (){
                print("Remove quantity");
                if (widget.cartDetails.customerBasketQuantity > 1) {
                  widget.onRemoveQuantity();
                } else {
                  widget.onDelete();
                }
              },
              child: Text(
                "-",
                style: CommonStyle.getAppFont(
                    color: CommonColors.color_707070,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );

    // return Container(
    //   margin: EdgeInsets.only(right: 12, left: 12, top: 12),
    //   padding: EdgeInsets.only(bottom: 12, left: 10, top: 8, right: 10),
    //   decoration: BoxDecoration(
    //       color: CommonColors.white,
    //       borderRadius: BorderRadius.all(Radius.circular(10)),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.grey.withOpacity(0.2),
    //           spreadRadius: 3,
    //           blurRadius: 5,
    //           offset: Offset(0, 1), // changes position of shadow
    //         ),
    //       ]),
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       ivProductImage,
    //       Flexible(
    //           child: Container(
    //         margin: EdgeInsets.only(left: 16),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             tvProductName,
    //             layoutProductPrice,
    //             tvDescountPrice,
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 /*layoutAddToWish,*/
    //                 Container(width: 10,),
    //                 Flexible(child: layoutAddRemoveQuantity)
    //               ],
    //             )
    //           ],
    //         ),
    //       ))
    //     ],
    //   ),
    // );

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
                margin: EdgeInsets.only(left: 16,top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    tvProductName,
                    layoutProductPrice,
                  ],
                ),
              )),
          layoutAddRemoveQuantity
        ],

      ),
    );
  }
}
