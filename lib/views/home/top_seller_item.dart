import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/brand_master.dart';
import 'package:big_mart/models/product_master.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/filter_dialog/filter_view_model.dart';
import 'package:big_mart/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'top_seller_item_view_model.dart';

class TopSellerItemView extends StatefulWidget {
  int position;
  bool isLoggedIn;
  ProductData productData;

  TopSellerItemView({this.position, this.isLoggedIn, this.productData});

  @override
  _TopSellerItemViewState createState() => _TopSellerItemViewState();
}

class _TopSellerItemViewState extends State<TopSellerItemView> {
  TopSellerItemViewModel mViewModel;
  double rating = 5.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<TopSellerItemViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      //mViewModel.getBrandList();
      print("top seller Login details =>" + widget.isLoggedIn.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<TopSellerItemViewModel>(context);
    mViewModel.mContext = context;
   /* final layoutTop = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          *//*widget.productData.productOfferPercentage > 0
              ? Container(
                  //padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                      //color: CommonColors.color_f1e795,
                    color: CommonColors.primaryAppBackground,
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
                )*//*
          widget.isLoggedIn
              ? SizedBox(
                  height: 30,
                  width: 40,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: IconButton(
                      //padding: EdgeInsets.only(right: 20),
                        icon: Icon(
                          widget.productData.productLiked
                          //     ? Icons.favorite_outlined
                          //     : Icons.favorite_outline,
                          // color: CommonColors.red,
                              ? Icons.playlist_add_check
                            : Icons.playlist_add,
                          size: 25,
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
                  ),
                )
              : Container(),
        ],
      ),
    );*/

    final layoutTop = Container(
      alignment: Alignment.topRight,
      child:SizedBox(
        height: 30,
        width: 40,
        child: IconButton(
            //padding: EdgeInsets.only(right: 20),
          onPressed: () async{
            if(widget.isLoggedIn){
              print("Favourite clicked.");
              mViewModel.addRemoveFromWishList(
                  productId: widget.productData.prouductId.toString(),
                  isAdd: !widget.productData.productLiked,
                  onSuccess: () {
                    widget.productData.productLiked =
                    !widget.productData.productLiked;
                  });
            }
            else{
              Navigator.push(context,
                  MaterialPageRoute(builder: (context){
                    return LoginView();
                  }));

            }
            },
          icon: Icon(
                widget.productData.productLiked
                    ? Icons.playlist_add_check
                    : Icons.playlist_add,
                size: 25,
              ),
              ),
        )
      );

    final ivProductImage = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            color: CommonColors.primaryAppBackground,
            height: 100,
            width: 100,
            //margin: EdgeInsets.only(top: 12),
            child: Image.network(
              widget.productData.productsImage,
              fit: BoxFit.fill,
            ),
          ),
      ],
    );

    final tvProductName = Container(
      padding: EdgeInsets.only(left: 8,right: 8),
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.productData.productName.toString(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: CommonStyle.getAppFont(
                color: CommonColors.primaryBlack,
                fontSize: 14,
                //fontWeight: FontWeight.w400
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

    final layoutProductPrice = Container(
      padding: EdgeInsets.only(top: 5,left: 8,right: 8),
      child: Row(
        children: [
          // Wrap(children: [
          Text("\$" +
               widget.productData.productPrice.toString(),
            style: CommonStyle.getAppFont(
                color: CommonColors.color_9f9f9f,
                fontSize: 16,
                fontWeight: FontWeight.w400),
            //  ),
            // ]
          ),

          Flexible(
              child: Row(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 2),
              //   child: Text(
              //     "IQ",
              //     style: CommonStyle.getAppFont(
              //         color: CommonColors.color_515c6f,
              //         fontSize: 12,
              //         fontWeight: FontWeight.w400),
              //   ),
              // ),
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
            // fontSize: 12,
            fontSize: 20,
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
                offset: Offset(0, 2), // changes position of shadow11
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

    final upperLayer = Container(
      color: CommonColors.primaryAppBackground,
      child: Container(
        child:Column(
          children: [
            Container(
              height: 150,
              child: Column(
                children: [
                  layoutTop,
                  SizedBox(height: 2,),
                  ivProductImage
                ],
              )
            ),
          ],
        )
      ),
    );

    final ratingBar = Container(
      padding: EdgeInsets.only(left: 8,right: 8),
      child:  SmoothStarRating(
        allowHalfRating: true,
        starCount: 5,
        rating: rating,
        size: 20.0,
        color: Colors.amber,
        borderColor: Colors.amber,
        spacing:0.0,
      ),

    );

    /*final brandName = Container(
      margin: EdgeInsets.only(left: 8,right: 8),
      child: Text(*//*widget.brandDetails.name.toString(),*//*
       mViewModel.brandList[0].name.length.toString(),
        style: TextStyle(color: CommonColors.color_9f9f9f,fontSize: 12,fontWeight: FontWeight.w300),),
    );*/

    // return Container(
    //   width: MediaQuery.of(context).size.width / 3,
    //   height: 100,
    //   margin: EdgeInsets.only(right: 8, left: widget.position == 0 ? 8 : 0),
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
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       layoutTop,
    //       ivProductImage,
    //       tvProductName,
    //       layoutProductPrice,
    //       tvDescountPrice,
    //       btnAddToCart
    //     ],
    //   ),
    // );

    return Container(
      width: 150,
      height: 180,
      margin: EdgeInsets.only(right: 30, left: widget.position == 0 ? 18 : 0),
      //padding: EdgeInsets.only(bottom: 12, left: 10, top: 8, right: 10),
      decoration: BoxDecoration(
          color: CommonColors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          upperLayer,
          SizedBox(height: 5),
          ratingBar,
          tvProductName,
         /* brandName,*/
          layoutProductPrice,
        ],
      ),
    );
  }
}
