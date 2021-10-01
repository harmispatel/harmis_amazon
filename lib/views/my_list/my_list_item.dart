import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/product_master.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_list_item_view_model.dart';

class MyListItemView extends StatefulWidget {
  int position;
  ProductData productData;

  MyListItemView({
    this.position,
    this.productData,
  });

  @override
  _MyListItemViewState createState() => _MyListItemViewState();
}

class _MyListItemViewState extends State<MyListItemView> {
  MyListItemViewModel mViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<MyListItemViewModel>(context, listen: false);
      mViewModel.attachContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<MyListItemViewModel>(context);
    final layoutSaleOff = Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      decoration: BoxDecoration(
          color: CommonColors.color_f1e795,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8))),
      child: Text(
        "23% OFF",
        style: CommonStyle.getAppFont(
            color: CommonColors.red, fontSize: 9, fontWeight: FontWeight.w400),
      ),
    );

    final ivProductImage = Container(
      height: 75,
      width: 60,
      margin: EdgeInsets.only(top: 12, left: 12),
      color: Colors.grey,
      child: FadeInImage(
        fit: BoxFit.fill,
        placeholder: AssetImage(LocalImages.ic_amazon_logo),
        image: NetworkImage(
          widget.productData.productsImage.toString(),
        ),
      ),
    );

    final tvProductName = Container(
      margin: EdgeInsets.only(top: 8),
      child: Text(
        widget.productData.productName.toString(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: CommonStyle.getAppFont(
            color: CommonColors.color_515c6f,
            fontSize: 15,
            fontWeight: FontWeight.w400),
      ),
    );

   /* final layoutProductPrice = Container(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Text(
            widget.productData.productPrice.toString(),
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
    );*/

    final layoutProductPrice = Container(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Text("\$" + widget.productData.productPrice.toString(),
            style: CommonStyle.getAppFont(
                color: CommonColors.dark_6060,
                fontSize: 15,
                fontWeight: FontWeight.w700),
          ),
          Flexible(
              child: Row(
                children: [
                  /*Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Text(
                      "IQ",
                      style: CommonStyle.getAppFont(
                          color: CommonColors.color_515c6f,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),*/
                /*  Flexible(
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

    final tvDescountPrice = Padding(
      padding: EdgeInsets.only(top: 4),
      child: Text(
        widget.productData.productOriginalPrice.toString() + " IQ",
        style: CommonStyle.getAppFont(
            color: CommonColors.color_96979d,
            fontSize: 12,
            decoration: TextDecoration.lineThrough,
            fontWeight: FontWeight.w400),
      ),
    );

    final layoutAddToWish = InkWell(
      onTap: () {},
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: IconButton(
                padding: EdgeInsets.only(bottom: 10),
                icon: Icon(
                  Icons.favorite_outline,
                  color: CommonColors.red,
                  size: 20,
                ),
                onPressed: () {
                  print("Favourite clicked.");
                  mViewModel.addRemoveFromWishList(
                      productId: widget.productData.prouductId.toString(),
                      isAdd: !widget.productData.productLiked,
                      onSuccess: () {
                        widget.productData.productLiked =
                            !widget.productData.productLiked;
                      });
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              S.of(context).addToWishList.toUpperCase(),
              // "t",
              style: CommonStyle.getAppFont(
                  color: CommonColors.color_515c6f,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );

    final btnAddToCart = InkWell(
      onTap: () {
        mViewModel.addToCart(
            productId: widget.productData.prouductId.toString());
      },
      child: Container(
        height: 30,
        width: 115,
        decoration: BoxDecoration(
            color: CommonColors.dark_6060,
            borderRadius: BorderRadius.all(Radius.circular(4)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ]),
        child: Center(
          child: Text(
            S.of(context).addToCart.toUpperCase(),
            style: CommonStyle.getAppFont(
                color: CommonColors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
        ),
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
                // tvDescountPrice,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /*layoutAddToWish,*/ Container(),
                    Flexible(child: btnAddToCart)
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
