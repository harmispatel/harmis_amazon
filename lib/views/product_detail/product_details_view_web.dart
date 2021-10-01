import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/product_master.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/currect_location_header/current_location_header_view.dart';
import 'package:big_mart/views/home/top_seller_item.dart';
import 'package:big_mart/views/login/login_view.dart';
import 'package:big_mart/views/product_detail/similar_product_web.dart';
import 'package:big_mart/views/search_product/search_product_view.dart';
import 'package:big_mart/widgets/shimmer_view/shimmer_horizontal_list.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'product_details_view_model.dart';
import 'review_list_item.dart';
import 'review_list_placeholder.dart';
import 'write_review/write_review_view.dart';

class ProductDetailsViewWeb extends StatefulWidget {
  String productId;

  ProductDetailsViewWeb({this.productId});

  @override
  _ProductDetailsViewWebState createState() => _ProductDetailsViewWebState();
}

class _ProductDetailsViewWebState extends State<ProductDetailsViewWeb> {
  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ProductDetailsViewModel mViewModel;
  double index = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<ProductDetailsViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.getProductDetails(widget.productId);
      mViewModel.getDealsProductList(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<ProductDetailsViewModel>(context);

    if (mViewModel.productDetails != null) {
      final layoutAppBar = Container(
        height: 55,
        padding: EdgeInsets.only(left: 5, right: 20, top: 7.5, bottom: 7.5),
        color: CommonColors.primaryColor,
        child: Row(
          children: [
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
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(seconds: 1),
                          pageBuilder: (_, __, ___) => SearchProductView()));
                },
                child: Container(
                  height: 40,
                  // margin: EdgeInsets.only(left: 16),
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      color: CommonColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    children: [
                      Container(
                        height: 11,
                        width: 11,
                        child: Image.asset(LocalImages.ic_search),
                      ),
                      Flexible(
                          child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: S.of(context).searchForProducts,
                                hintStyle: CommonStyle.getAppFont(
                                    color: CommonColors.color_515c6f,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.0),
                                contentPadding: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 14),
                                border: InputBorder.none,
                              ),
                              style: CommonStyle.getAppFont(
                                  color: CommonColors.primaryColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0),
                              maxLines: 1,
                              autocorrect: false,
                            ),
                          ),
                          kIsWeb
                              ? new Container()
                              : InkWell(
                                  onTap: () {
                                    // mViewModel.startBarcode();
                                    CommonUtils.scanBarcodeNormal(context);
                                  },
                                  child: Container(
                                    height: 16,
                                    width: 20,
                                    child: Image.asset(LocalImages.ic_scan),
                                  ),
                                ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

      final layoutHeader = Container(
        color: CommonColors.color_4a9b6f,
        padding: EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
        child: Row(
          children: [
            Container(
              height: 22,
              width: 14,
              child: Image.asset(LocalImages.ic_location_white),
            ),
            Flexible(
                child: Container(
              margin: EdgeInsets.only(left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).deliveryTo + " Maadi, Cario",
                    style: CommonStyle.getAppFont(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: CommonColors.white),
                  ),
                  Text(
                    S.of(context).change,
                    style: CommonStyle.getAppFont(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: CommonColors.white),
                  ),
                ],
              ),
            ))
          ],
        ),
      );

      final layoutTop = Container(
        margin: EdgeInsets.only(left: 16, right: 20),
        child: Stack(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       height: 158,
            //       width: 118,
            //       margin: EdgeInsets.only(top: 15),
            //       child: Image.network(
            //         mViewModel.productDetails.productImage,
            //         fit: BoxFit.fill,
            //       ),
            //     )
            //   ],
            // ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              decoration: BoxDecoration(
                  color: CommonColors.color_f1e795,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8))),
              child: Text(
                mViewModel.productDetails.result.productOfferPercentage.toString() +
                    "% " +
                    S.of(context).off,
                style: CommonStyle.getAppFont(
                    color: CommonColors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      );

      final layoutBanner =
          mViewModel.imageList != null && mViewModel.imageList.length > 0
              ? Stack(children: [
                  Column(
                    children: <Widget>[
                      Container(
                          height: 320,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: PageView.builder(
                            itemCount: mViewModel.imageList.length,
                            scrollDirection: Axis.horizontal,
                            reverse: false,
                            itemBuilder: (BuildContext context, int index) {
                              //return Container(height: 150, color: Colors.grey,);
                              return Container(
                                width: double.infinity,
                                height: 350,
                                color: CommonColors.white,
                                child: Image.network(
                                  mViewModel.imageList[index],
                                  fit: BoxFit.contain,
                                ),
                              );
                            },
                            onPageChanged: (int pageIndex) {
                              setState(() {
                                index = pageIndex.toDouble();
                              });
                              print('page chagned: ' + pageIndex.toString());
                            },
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: new DotsIndicator(
                          dotsCount: mViewModel.imageList.length,
                          position: this.index,
                          decorator: DotsDecorator(
                              color: CommonColors.color_4a9b6f,
                              // Inactive color
                              activeColor: CommonColors.primaryColor,
                              size: Size(8, 8),
                              activeSize: Size(16, 8),
                              activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: layoutTop,
                  )
                ])
              : Container();

      final tvProductName = Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Text(
          mViewModel.productDetails.result.productName.toString(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: CommonStyle.getAppFont(
              color: CommonColors.color_515c6f,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      );

      final layoutProductPrice = Container(
        padding: EdgeInsets.only(top: 8, left: 20, right: 20),
        child: Row(
          children: [
            Text(
              mViewModel.productDetails.result.productPrice.toString(),
              style: CommonStyle.getAppFont(
                  color: CommonColors.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  "IQ",
                  style: CommonStyle.getAppFont(
                      color: CommonColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      );

      final tvDescountPrice = Padding(
        padding: EdgeInsets.only(top: 4, left: 20, right: 20),
        child: Text(
          mViewModel.productDetails.result.productOriginalPrice.toString() + " IQ",
          style: CommonStyle.getAppFont(
              color: CommonColors.color_96979d,
              fontSize: 12,
              decoration: TextDecoration.lineThrough,
              fontWeight: FontWeight.w400),
        ),
      );

     /* final layoutBarcodeImage = mViewModel.productDetails.barcodeImage != null
          ? Padding(
              padding: EdgeInsets.only(top: 12, left: 20, right: 20),
              child: SvgPicture.network(
                mViewModel.productDetails.barcodeImage,
                semanticsLabel: 'A shark?!',
                height: 100,
                placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          CommonColors.primaryColor),
                    )),
              ),
            )
          : Container();*/

      final layoutSlotAvailibility = Container(
        margin: EdgeInsets.only(top: 4, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).scheduledDelivery,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: CommonStyle.getAppFont(
                  color: CommonColors.color_515c6f,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              mViewModel.productDetails.result.scheduledDelivery ?? "",
              overflow: TextOverflow.ellipsis,
              style: CommonStyle.getAppFont(
                  color: CommonColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                S.of(context).freeDelivery.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                style: CommonStyle.getAppFont(
                    color: CommonColors.primaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      );

      final layoutAddToFavAndShare = Container(
        margin: EdgeInsets.only(top: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              height: 1,
              color: CommonColors.color_dddddd,
            ),
            Container(
              height: 45,
              child: Row(
                children: [
                  mViewModel.loginDetails != null
                      ? Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              mViewModel.addRemoveFromWishList(
                                  productId: mViewModel
                                      .productDetails.result.prouductId
                                      .toString(),
                                  isAdd:
                                      !mViewModel.productDetails.result.productLiked,
                                  onSuccess: () {
                                    mViewModel.productDetails.result.productLiked =
                                        !mViewModel.productDetails.result.productLiked;
                                  });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: IconButton(
                                    padding: EdgeInsets.only(bottom: 10),
                                    icon: Icon(
                                      mViewModel.productDetails.result.productLiked
                                          ? Icons.favorite_outlined
                                          : Icons.favorite_outline,
                                      color: CommonColors.color_515c6f,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    S.of(context).addToWishList.toUpperCase(),
                                    overflow: TextOverflow.ellipsis,
                                    style: CommonStyle.getAppFont(
                                        color: CommonColors.color_515c6f,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      : Container(),
                  mViewModel.loginDetails != null
                      ? Container(
                          height: double.infinity,
                          width: 1,
                          color: CommonColors.color_dddddd,
                        )
                      : Container(),
                  Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          kIsWeb
                              ? mViewModel.webShare()
                              : mViewModel.shareImageWithText(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: IconButton(
                                  padding: EdgeInsets.only(bottom: 10),
                                  icon: Icon(
                                    Icons.share,
                                    color: CommonColors.color_515c6f,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    CommonUtils.showToastMessage(
                                        "Work is under developement");
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                S.of(context).share.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                style: CommonStyle.getAppFont(
                                    color: CommonColors.color_515c6f,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: CommonColors.color_dddddd,
            ),
          ],
        ),
      );

      final layoutCustomerReviews = Container(
        margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).customerReviews,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: CommonStyle.getAppFont(
                  color: CommonColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: mViewModel.productDetails.result.review != null &&
                      mViewModel.productDetails.result.review.length > 0
                  ? ListView.builder(
                      padding: EdgeInsets.only(top: 0),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: mViewModel.productDetails.result.review.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return InkWell(
                          onTap: () {},
                          child:Container()
                          /* ReviewListItemView(
                            position: index,
                            review: mViewModel.productDetails.result.review[index],
                          ),*/
                        );
                      })
                  : ReviewListPlaceHolderView(),
            ),
            mViewModel.loginDetails != null
                ? InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => WriteReviewView(),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        S.of(context).writeYourReview.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: CommonStyle.getAppFont(
                            color: CommonColors.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      );

      final layoutSimilarProducts = !mViewModel.isSimilarProductsLoading
          ? mViewModel.similarProductList.length > 0
              ? Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          S.of(context).similarProducts,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: CommonStyle.getAppFont(
                              color: CommonColors.color_515c6f,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      //mViewModel.experienceList.length > 0
                      // ?

                      Container(
                        height: 290,
                        margin: EdgeInsets.only(bottom: 4, top: 4),
                        child: ListView.builder(
                            padding: EdgeInsets.only(
                                top: 10, left: 0, right: 0, bottom: 10),
                            itemCount: mViewModel.similarProductList.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder:
                                (BuildContext buildContext, int index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                            transitionDuration:
                                                Duration(seconds: 1),
                                            pageBuilder: (_, __, ___) =>
                                                ProductDetailsViewWeb(
                                                  productId: mViewModel
                                                      .similarProductList[index]
                                                      .prouductId
                                                      .toString(),
                                                )));
                                  },
                                  child: SimilarProductViewWeb(
                                    position: index,
                                    isLoggedIn: mViewModel.loginDetails != null,
                                    productData:
                                        mViewModel.similarProductList[index],
                                  ));
                            }),
                      )
                      //: Container()
                    ],
                  ),
                )
              : Container()
          : ShimmerHorizontalList();

      final btnAddToCart = InkWell(
        onTap: () {
          mViewModel.addToCart(
              productId: mViewModel.productDetails.result.prouductId.toString());
        },
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width * 0.45,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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

      return Scaffold(
        //key: mViewModel.scaffoldkey,
        backgroundColor: CommonColors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //layoutTop,
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [layoutBanner, btnAddToCart]),
                        SingleChildScrollView(
                            // padding: EdgeInsets.only(bottom: 60),
                            child: Container(
                          // height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width * 0.45,
                          margin: EdgeInsets.only(right: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //layoutTop,
                                tvProductName,
                                layoutProductPrice,
                                tvDescountPrice,
                                //layoutBarcodeImage,
                                layoutSlotAvailibility,
                                layoutAddToFavAndShare,
                              ]),
                        ))
                      ]),
                  layoutCustomerReviews,
                  layoutSimilarProducts,
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                layoutAppBar,
                //CurrentLocationHeaderView(),
              ],
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: SpinKitRing(
            color: CommonColors.primaryColor,
            size: 40,
            lineWidth: 4,
          ),
        ),
      );
    }
  }
}
