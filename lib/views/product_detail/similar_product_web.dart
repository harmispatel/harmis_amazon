import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/product_master.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/product_detail/product_details_view_web.dart';
import 'package:big_mart/views/product_detail/similar_product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SimilarProductViewWeb extends StatefulWidget {
  int position;
  bool isLoggedIn;
  ProductData productData;

  SimilarProductViewWeb({this.position, this.isLoggedIn, this.productData});

  @override
  SimilarProductViewWebState createState() => SimilarProductViewWebState();
}

class SimilarProductViewWebState extends State<SimilarProductViewWeb> {
  SimilarProduactViewModel mViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel =
          Provider.of<SimilarProduactViewModel>(context, listen: false);
      mViewModel.attachContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SimilarProduactViewModel>(context);
    final layoutTop = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.productData.productOfferPercentage > 0
              ? Container(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                      color: CommonColors.color_f1e795,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(8))),
                  child: Text(
                    widget.productData.productOfferPercentage.toString() +
                        "% " +
                        S.of(context).off,
                    style: CommonStyle.getAppFont(
                        color: CommonColors.red,
                        fontSize: 9,
                        fontWeight: FontWeight.w400),
                  ),
                )
              : Container(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                      color: CommonColors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(8))),
                  child: Text(
                    "" + " " + "",
                    style: CommonStyle.getAppFont(
                        color: CommonColors.red,
                        fontSize: 9,
                        fontWeight: FontWeight.w400),
                  ),
                ),
          widget.isLoggedIn
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: IconButton(
                      padding: EdgeInsets.only(bottom: 10),
                      icon: Icon(
                        widget.productData.productLiked
                            ? Icons.favorite_outlined
                            : Icons.favorite_outline,
                        color: CommonColors.red,
                        size: 20,
                      ),
                      onPressed: () async {
                        print("Favourite clicked.");
                        mViewModel.addRemoveFromWishList(
                            productId: widget.productData.prouductId.toString(),
                            isAdd: !widget.productData.productLiked,
                            onSuccess: () {
                              widget.productData.productLiked =
                                  !widget.productData.productLiked;
                            });
                      }),
                )
              : Container(),
        ],
      ),
    );

    final ivProductImage = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 75,
          width: 60,
          margin: EdgeInsets.only(top: 12),
          child: Image.network(
            widget.productData.productsImage,
            fit: BoxFit.fill,
          ),
        )
      ],
    );

    final tvProductName = Container(
      padding: EdgeInsets.only(top: 10),
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.productData.productName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: CommonStyle.getAppFont(
                color: CommonColors.color_515c6f,
                fontSize: 15,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );

    final layoutProductPrice = Container(
      padding: EdgeInsets.only(top: 5),
      child: Row(
        children: [
          // Wrap(children: [
          Text(
            widget.productData.productPrice.toString(),
            style: CommonStyle.getAppFont(
                color: CommonColors.primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w700),
            //  ),
            // ]
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
              /*Flexible(
                child: Text(
                  "/Piece",
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
        widget.productData.productOriginalPrice + " IQ",
        style: CommonStyle.getAppFont(
            color: CommonColors.color_96979d,
            fontSize: 12,
            decoration: TextDecoration.lineThrough,
            fontWeight: FontWeight.w400),
      ),
    );

    final btnAddToCart = InkWell(
      onTap: () {
        mViewModel.addToCart(
            productId: widget.productData.prouductId.toString());
      },
      child: Container(
        margin: EdgeInsets.only(top: 8),
        height: 35,
        decoration: BoxDecoration(
            color: CommonColors.primaryColor,
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
      width: MediaQuery.of(context).size.width / 3,
      height: 100,
      margin: EdgeInsets.only(right: 8, left: widget.position == 0 ? 8 : 0),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          layoutTop,
          ivProductImage,
          tvProductName,
          layoutProductPrice,
          tvDescountPrice,
          btnAddToCart
        ],
      ),
    );
  }
}
