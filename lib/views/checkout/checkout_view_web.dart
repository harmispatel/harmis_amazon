import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/address.dart';
import 'package:big_mart/models/cart_master.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/checkout/checkout_item_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'checkout_view_model.dart';

class CheckoutViewWeb extends StatefulWidget {
  List<CartDetails> cartList;
  String totalPrice;
  AddressDetails addressDetails;
  String orderId;

  CheckoutViewWeb(
      {this.cartList, this.totalPrice, this.addressDetails, this.orderId});

  @override
  _CheckoutViewWebState createState() => _CheckoutViewWebState();
}

class _CheckoutViewWebState extends State<CheckoutViewWeb> {
  final globalKey = new GlobalKey();
  CheckoutViewModel mViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<CheckoutViewModel>(context, listen: false);
      mViewModel.attachContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<CheckoutViewModel>(context);

    final layoutCartList = Container(
      child: widget.cartList.length > 0
          ? Container(
              width: MediaQuery.of(context).size.width * 0.6,
              margin: EdgeInsets.only(right: 12, left: 12, bottom: 25),
              padding:
                  EdgeInsets.only(bottom: 12, left: 12, top: 12, right: 12),
              //height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 320, mainAxisSpacing: 20),
                  padding: EdgeInsets.only(bottom: 13),
                  shrinkWrap: true,
                  itemCount: widget.cartList.length,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return CheckoutItemViewWeb(
                      cartDetails: widget.cartList[index],
                    );
                  }),
            )
          : Container(),
    );

    final deliveryAddress = Container(
      //width: double.infinity,
      margin: EdgeInsets.only(right: 12, left: 6, top: 12),
      padding: EdgeInsets.only(bottom: 12, left: 12, top: 12, right: 12),
      width: MediaQuery.of(context).size.width * 0.35,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).deliveryAddress,
            style: CommonStyle.getAppFont(
                color: CommonColors.color_707070,
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            widget.addressDetails.firstName.toString(),
            style: CommonStyle.getAppFont(
                color: CommonColors.color_96979d,
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.addressDetails.mobile.toString(),
            style: CommonStyle.getAppFont(
                color: CommonColors.color_96979d,
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.addressDetails.address.toString() +
                ", " +
                widget.addressDetails.area.toString() +
                ", " +
                widget.addressDetails.city.toString(),
            style: CommonStyle.getAppFont(
                color: CommonColors.color_96979d,
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5,
          ),
          CommonUtils.isEmpty(widget.addressDetails.landmark)
              ? Container()
              : Text(
                  widget.addressDetails.landmark,
                  style: CommonStyle.getAppFont(
                      color: CommonColors.color_96979d,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
        ],
      ),
    );

    final layoutBottom = widget.cartList.length > 0
        ? Container(
            padding: EdgeInsets.all(20),
            color: CommonColors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            S.of(context).subTotal,
                            style: CommonStyle.getAppFont(
                                color: CommonColors.color_515c6f,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "(" +
                                widget.cartList.length.toString() +
                                " " +
                                S.of(context).items +
                                ")",
                            style: CommonStyle.getAppFont(
                                color: CommonColors.color_515c6f,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Text(
                        widget.totalPrice.toString() + " IQ",
                        style: CommonStyle.getAppFont(
                            color: CommonColors.color_515c6f,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (widget.orderId == null) {
                      mViewModel.placeOrder(
                          addressId:
                              widget.addressDetails.addressId.toString());
                    } else {
                      mViewModel.buyAgain(
                          orderId: widget.orderId.toString(),
                          addressId:
                              widget.addressDetails.addressId.toString());
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: CommonColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Center(
                      child: Text(
                        S.of(context).sendOrder.toUpperCase(),
                        style: CommonStyle.getAppFont(
                            color: CommonColors.white,
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : Container();

    final mBody = Container(
        margin: EdgeInsets.only(bottom: 100),
        child: SingleChildScrollView(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [layoutCartList, deliveryAddress],
        )));

    return Scaffold(
      key: globalKey,
      backgroundColor: CommonColors.white,
      appBar: AppBar(
        backgroundColor: CommonColors.primaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.only(left: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  height: 15,
                  child: Image.asset(
                    LocalImages.ic_arrow_back,
                    color: CommonColors.white,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 14, right: 10),
                  child: Text(
                    S.of(context).checkout,
                    style: CommonStyle.getAppFont(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: CommonColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          mBody,
          Align(
            alignment: Alignment.bottomCenter,
            child: layoutBottom,
          )
        ],
      ),
    );
  }
}
