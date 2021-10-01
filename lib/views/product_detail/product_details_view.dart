import 'dart:convert';

import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/product_master.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/cart/cart_list_view.dart';
import 'package:big_mart/views/currect_location_header/current_location_header_view.dart';
import 'package:big_mart/views/home/home_view.dart';
import 'package:big_mart/views/home/top_seller_item.dart';
import 'package:big_mart/views/login/login_view.dart';
import 'package:big_mart/views/my_orders/my_orders_view.dart';
import 'package:big_mart/views/search_product/search_product_view.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:big_mart/widgets/product_selection_layout/product_selection.dart';
import 'package:big_mart/widgets/shimmer_view/shimmer_horizontal_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'product_details_view_model.dart';
import 'review_list_item.dart';
import 'review_list_placeholder.dart';
import 'write_review/write_review_view.dart';
import 'package:html/parser.dart' as html_parser;

class ProductDetailsView extends StatefulWidget {
  String productId;
  ProductData productData;
  ProductDetailsView({this.productId,this.productData});

  @override
  _ProductDetailsViewState createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final globalKey = new GlobalKey();
  ProductDetailsViewModel mViewModel;
  double index = 0;
  bool ishidden = false;
  final PageController controller = PageController(initialPage: 0);
  final _htmlEscape = HtmlEscape(HtmlEscapeMode.element);





  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<ProductDetailsViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.getProductDetails(widget.productId);
      /*mViewModel.getDealsProductList(widget.productId);*/
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
                 mViewModel.onsizepressed = 0;
                 mViewModel.oncolorpressed = 0;
                 mViewModel.notifyListeners();
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
                          InkWell(
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

   /*   final layoutTop = Container(
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
                mViewModel.productDetails.productOfferPercentage.toString() +
                    "% " +
                    S.of(context).off,
                style: CommonStyle.getAppFont(
                    color: CommonColors.red,
                    fontSize: 9,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      );*/

      final layoutBanner =
          mViewModel.imageList != null && mViewModel.imageList.length > 0
              ? Column(
                  children: <Widget>[
                    Container(
                        height: 320,
                        child: PageView.builder(
                          itemCount: mViewModel.imageList.length,
                          scrollDirection: Axis.horizontal,
                          reverse: false,
                          itemBuilder: (BuildContext context, int index) {
                            //return Container(height: 150, color: Colors.grey,);
                            return Container(
                              width: double.infinity,
                              height: 320,
                              color: CommonColors.white,
                              child: Image.network(
                                mViewModel.imageList[index],
                              )
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
                )
              : Container();

     /* final tvProductName = Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Text(
          mViewModel.productDetails.productName.toString(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: CommonStyle.getAppFont(
              color: CommonColors.color_515c6f,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      );*/

    /*  final layoutProductPrice = Container(
        padding: EdgeInsets.only(top: 8, left: 20, right: 20),
        child: Row(
          children: [
            Text(
              mViewModel.productDetails.productPrice.toString(),
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
      );*/

      /*final tvDescountPrice = Padding(
        padding: EdgeInsets.only(top: 4, left: 20, right: 20),
        child: Text(
          mViewModel.productDetails.productOriginalPrice.toString() + " IQ",
          style: CommonStyle.getAppFont(
              color: CommonColors.color_96979d,
              fontSize: 12,
              decoration: TextDecoration.lineThrough,
              fontWeight: FontWeight.w400),
        ),
      );*/

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

      /*final layoutSlotAvailibility = Container(
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
              mViewModel.productDetails?.scheduledDelivery ?? "",
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
      );*/

    /*  final layoutAddToFavAndShare = Container(
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
                                      .productDetails.prouductId
                                      .toString(),
                                  isAdd:
                                      !mViewModel.productDetails.productLiked,
                                  onSuccess: () {
                                    mViewModel.productDetails.productLiked =
                                        !mViewModel.productDetails.productLiked;
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
                                      mViewModel.productDetails.productLiked
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
                          mViewModel.shareImageWithText(context);
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
      );*/

     /* final layoutCustomerReviews = Container(
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
                          child: ReviewListItemView(
                            position: index,
                            review: mViewModel.productDetails.result.review[index],
                          ),
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
      );*/

      final layoutCustomerReviews = Container(
        margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      child:/*Container()*/
                      ReviewListItemView(
                        position: index,
                        review: mViewModel.productDetails.result.review[index],
                      ),
                    );
                  })
                  : Container(),
            ),
            mViewModel.loginDetails != null
                ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    S.of(context).writeYourReview.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: CommonStyle.getAppFont(
                        color: CommonColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  ),
                  IconButton(
                      onPressed: (){
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) => WriteReviewView(),
                        );
                      },
                      icon: Icon(Icons.add),color: CommonColors.black,iconSize: 20,)
                ]
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
                              return TopSellerItemView(
                                position: index,
                                isLoggedIn: mViewModel.loginDetails != null,
                                productData:
                                    mViewModel.similarProductList[index],
                              );
                            }),
                      )
                      //: Container()
                    ],
                  ),
                )
              : Container()
          : ShimmerHorizontalList();


      /*final prodImage = Container(
          child: Container(
            child: Stack(
              children: [
              Center(
                child: Container(
                  height: 360,
                  width: 250,
                  child: PageView(
                  scrollDirection: Axis.horizontal,
                  controller: controller,
                  children: <Widget>[
                    Center(
                      child:Image.network(mViewModel.imageList.first),
                    ),
                   *//* Center(
                      child:Image.network('https://i.pinimg.com/736x/97/35/68/97356858f557779d18e86f6c1457bdf0.jpg'),
                    ),
                    Center(
                      child: Image.network('https://stylesatlife.com/wp-content/uploads/2019/04/Sleeve-Design-Blazer-For-Men.jpeg'),
                    )*//*
                  ],
            ),
                ),
              ),
                Positioned(
                  top: 150,
                    left: 10,
                    child: IconButton(
                        onPressed: previousPage,
                        icon: Icon(Icons.arrow_back_ios,size: 30,color: Colors.grey,)),
                    ),
                Positioned(
                  top: 150,
                  left: MediaQuery.of(context).size.width - 50,
                  child: IconButton(
                      onPressed: nextPage,
                      icon: Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey)),
                )
                  ],
            ),
          ),
      );*/

      final prodImage = Container(
        child:  mViewModel.imageList.length > 1
            ? Container(
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: 320,
                  child: PageView.builder(
                      itemCount: mViewModel.imageList.length,
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            width: double.infinity,
                            height: 320,
                            color: CommonColors.white,
                            child: Image.network(
                              mViewModel.imageList[index],
                            )
                        );
                      }
                    /* Center(
                      child:Image.network('https://i.pinimg.com/736x/97/35/68/97356858f557779d18e86f6c1457bdf0.jpg'),
                    ),
                    Center(
                      child: Image.network('https://stylesatlife.com/wp-content/uploads/2019/04/Sleeve-Design-Blazer-For-Men.jpeg'),
                    )*/

                  ),
                ),
              ),
              Positioned(
                top: 150,
                left: 10,
                child: IconButton(
                    onPressed: previousPage,
                    icon: Icon(Icons.arrow_back_ios,size: 30,color: Colors.grey,)),
              ),
              Positioned(
                top: 150,
                left: MediaQuery.of(context).size.width - 50,
                child: IconButton(
                    onPressed: nextPage,
                    icon: Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey)),
              )
            ],
          ),
        )
            :Container(
          child:Center(
          child: Container(
            height: 320,
            child: PageView.builder(
                itemCount: mViewModel.imageList.length,
                scrollDirection: Axis.horizontal,
                controller: controller,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      width: double.infinity,
                      height: 320,
                      color: CommonColors.white,
                      child: Image.network(
                        mViewModel.imageList[index],
                      )
                  );
                }
              /* Center(
                      child:Image.network('https://i.pinimg.com/736x/97/35/68/97356858f557779d18e86f6c1457bdf0.jpg'),
                    ),
                    Center(
                      child: Image.network('https://stylesatlife.com/wp-content/uploads/2019/04/Sleeve-Design-Blazer-For-Men.jpeg'),
                    )*/

            ),
          ),),
      ));

      final prodInfo = Container(
        decoration: BoxDecoration(
            color: CommonColors.white,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),),
        //   boxShadow: [
        //     BoxShadow(
        //   color: Colors.grey,
        //   blurRadius: 1.0,
        // ),]
        ),

        child: Container(
          margin: EdgeInsets.only(left: 15,right: 15),
          child: Column(
            children: [
              SizedBox(height: 12,),
                    Row(
                      children: [
                        SmoothStarRating(
                          allowHalfRating: true,
                          starCount: 5,
                          rating: 5.0,
                          size: 20.0,
                          color: Colors.amber,
                          borderColor: Colors.amber,
                          spacing:0.0,
                        ),
                        SizedBox(width: 8,),
                        Text("(134)",
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 14,fontWeight: FontWeight.bold
                          ),)
                      ],
                    ),
              SizedBox(height: 8,),
              Row(
                children: [
                 /* Text("KITON",style: TextStyle(
                    color: CommonColors.lightGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(width: 7,),*/
                  Flexible(
                    child: Text(mViewModel.productDetails.result.productName,
                      style: TextStyle(
                        color: CommonColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                ],
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Text("\$" + mViewModel.productPrice.toString()
                    ,style: TextStyle(
                      color: CommonColors.black,
                      fontSize: 18,
                  ),),
                ],
              ),

                Padding(
                  padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
                  child: ExpandText(mViewModel.productDetails.result.productDescription.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' '),
                    textAlign: TextAlign.start,
                    arrowPadding: EdgeInsets.only(top: 10),
                    maxLines: 2,
                    style: TextStyle(fontSize: 15),
                  ),
                ),


              /*Visibility(
                visible: ishidden,
                  child:  Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                          child: Html(
                              data:mViewModel.productDetails.result.productDescription.toString()))
                    ],
                  ),
                  ),

              InkWell(
                onTap: (){
                  setState(() {
                    ishidden = !ishidden;
                  });
                },
                child: Container(
                  height: 30,
                  width: 30,
                  child: Icon(
                      ishidden
                          ?Icons.keyboard_arrow_up_sharp
                          :Icons.keyboard_arrow_down_sharp),),
              ),*/

            ],
          ),
        ),
      );

      final reviews = Container(
        child: Column(
         children: [
           SizedBox(height: 18,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Padding(
                 padding: const EdgeInsets.only(left: 15,right: 15),
                 child: Text(S.of(context).reviews,
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 20
                   ),),
               ),
               Padding(
                 padding: const EdgeInsets.only(right: 15,left: 15),
                 child: Icon(Icons.arrow_forward_ios,size: 16,color: Colors.grey),
               ),
             ],
           )
         ],
        ),
      );

      final userReview = Container(
          padding: EdgeInsets.only(left: 15,top: 15,bottom: 10),
          child:mViewModel.loginDetails != null
            ?Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15,left: 20),
                child: Text("Add Reviews",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black
                  ),),
              )

            ],
          )


          /*Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(*//*mViewModel.productDetails.review[0].customerPicture??*//*"https://st1.bollywoodlife.com/wp-content/uploads/2021/04/BTS-V-Kim-Taehyhung-Taehyung.png"),
                      fit: BoxFit.fill
                  ),
                ),
              ),
              Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text((*//*mViewModel.productDetails.result.review.length==0?"Harmis Test":mViewModel.productDetails.result.review[0]*//*"Harmis"),style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 5,),
                        SmoothStarRating(
                          allowHalfRating: true,
                          starCount: 5,
                          rating: 5.0,
                          size: 20.0,
                          color: Colors.amber,
                          borderColor: Colors.amber,
                          spacing:0.0,
                        ),
                        SizedBox(height: 5,),
                        Text(*//*mViewModel.productDetails.result.review.length==0?"Good":mViewModel.productDetails.result.review[0]*//*"Good",style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300,
                          color: CommonColors.color_707070
                        ),),
                      ],
                    ),
                  )
              ),
            ],
          )*/
        :Container()
      );

      final bottomLayout = Container(
        color: CommonColors.white,
        height: 62,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
                IconButton(onPressed: (){
                  mViewModel.onsizepressed = 0;
                  mViewModel.oncolorpressed = 0;
                  mViewModel.notifyListeners();
                      Navigator.pop(context);
                  },
                    icon: Icon(Icons.arrow_back,size: 35, color: Colors.black38,)),
                InkWell(
                  onTap: (){
                    mViewModel.addToCart(
                        productId: widget.productId.toString()
                    );
                  },
                  child: Container(
                    width: 200,
                    height: 40,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text(
                        S.of(context).addToCart,
                        style: TextStyle(
                            color: CommonColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20,bottom: 5),
                  child:IconButton(
                        onPressed: (){
                        /* mViewModel.loginDetails==null
                             ?Navigator.push(context,
                             MaterialPageRoute(builder: (context){
                               return LoginView();
                             }))
                             : print("Favourite clicked");
                                mViewModel.addRemoveFromWishList(
                                productId: mViewModel
                                    .productDetails.result.prouductId
                                    .toString(),
                                isAdd:
                                !mViewModel.productDetails.result.productLiked,
                                onSuccess: () {
                                mViewModel.productDetails.result.productLiked =
                                !mViewModel.productDetails.result.productLiked;
                                });*/
                          if (mViewModel.loginDetails != null) {
                            print("Favourite clicked");
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
                          }
                          else{
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context){
                                  return LoginView();
                                }));
                          }
                        },
                        icon: Icon(
                          mViewModel.productDetails.result.productLiked
                              ? Icons.playlist_add_check
                              : Icons.playlist_add,
                          size: 35,
                          color: Colors.black38,
                        )),
                  )
          ],
        ),
      );

      final btnAddToCart = InkWell(
        onTap: () {
          mViewModel.addToCart(
              productId: mViewModel.productDetails.result.prouductId.toString());
          },
        child: Container(
          height: 40,
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
                S.of(context).addToCart,
              style: TextStyle(
                  color: CommonColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      );




    //   return Scaffold(
    //     key: mViewModel.scaffoldkey,
    //     backgroundColor: CommonColors.white,
    //     body: Stack(
    //       children: [
    //         SingleChildScrollView(
    //           padding: EdgeInsets.only(bottom: 60),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 height: MediaQuery.of(context).padding.top +
    //                     AppBar().preferredSize.height +
    //                     40,
    //               ),
    //               //layoutTop,
    //               layoutBanner,
    //               layoutTop,
    //               tvProductName,
    //               layoutProductPrice,
    //               tvDescountPrice,
    //               layoutBarcodeImage,
    //               layoutSlotAvailibility,
    //               layoutAddToFavAndShare,
    //               layoutCustomerReviews,
    //               layoutSimilarProducts,
    //             ],
    //           ),
    //         ),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             SizedBox(
    //               height: MediaQuery.of(context).padding.top,
    //             ),
    //             layoutAppBar,
    //             CurrentLocationHeaderView(),
    //           ],
    //         ),
    //         Align(
    //           alignment: Alignment.bottomCenter,
    //           child: btnAddToCart,
    //         )
    //       ],
    //     ),
    //   );
    // } else {
    //   return Scaffold(
    //     body: Center(
    //       child: SpinKitRing(
    //         color: CommonColors.primaryColor,
    //         size: 40,
    //         lineWidth: 4,
    //       ),
    //     ),
    //   );
    // }
      
      return Scaffold(
        key: globalKey,
        backgroundColor: CommonColors.darkk,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  prodImage,
                  //SizedBox(height: 30,),
                  prodInfo,
                  mViewModel.productDetails.result.option != null?Colorview(): Container(),
                  reviews,
                  layoutCustomerReviews
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: bottomLayout,
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: SpinKitRing(
            color: Colors.orangeAccent,
            size: 40,
            lineWidth: 4,
          ),
        ),
      );
    }
  }
  /*void _popupDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(borderRadius:
            BorderRadius.all(Radius.circular(18))),
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(LocalImages.ic_dialog,height: 160,width: 160,),
                      SizedBox(height: 2,),
                      Text("Success!",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("Your order has been sucessfully added.",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 14),textAlign: TextAlign.center,),
                      ),
                      InkWell(
                        onTap: (){
                          *//*Navigator.of(context)
                            .pushNamedAndRemoveUntil('/bottomNavigationBar', (Route<dynamic> route) => false);*//*
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                                builder: (context) => bottomNavigationBar(),
                              ), (route) => false);
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width - 150,
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Center(
                            child: Text("Continue Shopping",
                              style: TextStyle(
                                  color: CommonColors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return MyOrdersView();
                                  }));
                            },
                            child: Text("Go to Orders",
                              style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 18),)),
                      ),
                    ],
                  )
              )
            ],
          );
        });
  }*/

  void nextPage(){
    controller.animateToPage(controller.page.toInt() + 1,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn
    );
  }

  void previousPage(){
    controller.animateToPage(controller.page.toInt() -1,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn
    );
  }
}
