import 'dart:io';
import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/categories/categories_view.dart';
import 'package:big_mart/views/categories/sub_cat_view.dart';
import 'package:big_mart/views/home/deals_item.dart';
import 'package:big_mart/views/home/home_category_item_view.dart';
import 'package:big_mart/views/home/home_view_model.dart';
import 'package:big_mart/views/home/offers_item.dart';
import 'package:big_mart/views/home/top_seller_item.dart';
import 'package:big_mart/views/product_detail/product_details_view.dart';
import 'package:big_mart/views/product_list/product_list_view.dart';
import 'package:big_mart/views/search_product/search_product_view.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar_view_model.dart';
import 'package:big_mart/widgets/no_data_widget.dart';
import 'package:big_mart/widgets/shimmer_view/shimmer_banner.dart';
import 'package:big_mart/widgets/shimmer_view/shimmer_horizontal_list.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final globalKey = new GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  HomeViewModel mViewModel;
 /* var scaffoldkey = new GlobalKey<ScaffoldState>();*/
  double index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachContext(context);
      mViewModel.setGlobalKey(scaffoldkey);
      mViewModel.getLoginDetails();
     // mViewModel.getBannerList();
      mViewModel.initCategoryList();
      /*mViewModel.getOfferProductList();
      mViewModel.getDealsProductList();*/
      mViewModel.getTopSellerList();
      mViewModel.getPopularProductList();
      print("init call in home");
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<HomeViewModel>(context);

    final layoutAppBar = Container(
      height: 90,
      padding: EdgeInsets.only(left: 20, right: 20),
      color: CommonColors.primaryColor,
      child: Row(
        children: [
          Container(
            height: 31,
            width: 38,
            child: Image.asset(LocalImages.ic_home_header),
          ),
          SizedBox(
            width: 16,
              child: Row(
                children: [
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
                          padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              color: CommonColors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 11,
                                width: 11,
                                child: Image.asset(LocalImages.ic_search),
                              ),
                              Flexible(
                                  child: Container(
                                    child: TextField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        hintText: S.of(context).searchForProducts,
                                        hintStyle: CommonStyle.getAppFont(
                                            color: CommonColors.color_515c6f,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15.0),
                                        contentPadding:
                                        EdgeInsets.only(left: 20, right: 20, bottom: Platform.isAndroid ? mViewModel.languageCode == AppConstants.LANGUAGE_ARABIC ? 8 : 14 : 14),
                                        border: InputBorder.none,
                                      ),
                                      style: CommonStyle.getAppFont(
                                          color: CommonColors.primaryColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.0),
                                      maxLines: 1,
                                      autocorrect: false,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ))

                ],
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

    final layoutImages = !mViewModel.isBannerLoading
        ? mViewModel.bannerList.length > 0
            ? Column(
                children: <Widget>[
                  Container(
                      height: 200,
                      child: PageView.builder(
                        itemCount: mViewModel.bannerList.length,
                        scrollDirection: Axis.horizontal,
                        reverse: false,
                        itemBuilder: (BuildContext context, int index) {
                          //return Container(height: 150, color: Colors.grey,);
                          return Container(
                            width: double.infinity,
                            height: 200,
                            color: CommonColors.color_c4c4c4,
                            child: Image.network(
                              mViewModel.bannerList[index].slidersImg,
                              // "http://192.168.1.116/Aqark/_appadmin_detailz/resources/assets/img/property_logo.png",
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                        onPageChanged: (int pageIndex) {
                          setState(() {
                            index = pageIndex.toDouble();
                          });
                          print('page changed: ' + pageIndex.toString());
                        },
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: new DotsIndicator(
                      dotsCount: mViewModel.bannerList.length,
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
            : Container()
        : ShimmerBanner();

    final layoutOffers = !mViewModel.isOfferProductsLoading
        ? mViewModel.offerProductList.length > 0
            ? Container(
                margin: EdgeInsets.only(bottom: 20, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        S.of(context).offers,
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
                      height: 160,
                      margin: EdgeInsets.only(bottom: 4, top: 4),
                      child: ListView.builder(
                          padding: EdgeInsets.only(
                              top: 10, left: 0, right: 0, bottom: 10),
                          itemCount: mViewModel.offerProductList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext buildContext, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                            Duration(seconds: 1),
                                        pageBuilder: (_, __, ___) =>
                                            ProductDetailsView(
                                              productId: mViewModel
                                                  .offerProductList[index]
                                                  .prouductId
                                                  .toString(),
                                            )));
                              },
                              child: OffersItemView(
                                position: index,
                                productData: mViewModel.offerProductList[index],
                              ),
                            );
                          }),
                    )
                    //: Container()
                  ],
                ),
              )
            : Container()
        : ShimmerHorizontalList();

    final layoutAdsImage = mViewModel.bannerList.length > 0
        ? Container(
            width: double.infinity,
            height: 100,
            margin: EdgeInsets.only(bottom: 24),
            child: Image.network(
              mViewModel
                  .bannerList[mViewModel.bannerList.length - 1].slidersImg,
              fit: BoxFit.fill,
            ),
          )
        : Container();

    final layoutCategories = !mViewModel.isCategoriesLoading
        ? mViewModel.categoryList.length > 0
            ? Container(
                margin: EdgeInsets.only(bottom: 5, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                        /*Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            S.of(context).categories,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: CommonStyle.getAppFont(
                                color: CommonColors.color_515c6f,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                    mViewModel.experienceList.length > 0
                    ?*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                                S.of(context).categories,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: CommonStyle.getAppFont(
                                    color: CommonColors.primaryBlack,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: IconButton(
                            onPressed: (){
                             /* Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CategoriesView()),
                              );*/
                              Provider.of<BottomNavBarViewModel>(context,listen: false).changeTab(1);
                            },
                            icon: Icon(Icons.arrow_forward_ios,
                            color: CommonColors.color_9f9f9f,
                            size: 18.0,),)
                        )
                      ],
                    ),
                    Container(
                      height: 165,
                      margin: EdgeInsets.only(bottom: 4, top: 4),
                      child: ListView.builder(
                          padding: EdgeInsets.only(
                              top: 10, left: 0, right: 0, bottom: 10),
                          itemCount: mViewModel.categoryList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext buildContext, int index) {
                            return InkWell(
                              onTap: () {
                                AppPreferences().setFilter(null);
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                            Duration(seconds: 1),
                                        pageBuilder: (_, __, ___) =>
                                           /* ProductListView(
                                              categoryId: mViewModel
                                                  .categoryList[index]
                                                  .categoriesId
                                                  .toString(),
                                            )*/
                                        SubCategory(catId: mViewModel.categoryList[index].categoriesId,)
                                    ));
                              },
                              child: HomeCategoryItemView(
                                position: index,
                                category: mViewModel.categoryList[index],
                              ),
                            );
                          }),
                    )
                    //: Container()
                  ],
                ),
              )
            : Container()
        : ShimmerHorizontalList();

    final layoutDeals = !mViewModel.isDealsProductsLoading
        ? mViewModel.dealsProductList.length > 0
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
                        S.of(context).deals,
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
                      height: 160,
                      margin: EdgeInsets.only(bottom: 4, top: 4),
                      child: ListView.builder(
                          padding: EdgeInsets.only(
                              top: 10, left: 0, right: 0, bottom: 10),
                          itemCount: mViewModel.dealsProductList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext buildContext, int index) {
                            return DealsItemView(
                              position: index,
                              productData: mViewModel.dealsProductList[index],
                            );
                          }),
                    )
                    //: Container()
                  ],
                ),
              )
            : Container()
        : ShimmerHorizontalList();

    final layoutTopSeller = !mViewModel.isTopSellerLoading
        ? mViewModel.topSellerList.length > 0
            ? Container(
                margin: EdgeInsets.only(
                  bottom: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                        // Container(
                        //   margin: EdgeInsets.only(left: 20, right: 20),
                        //   child: Text(
                        //     S.of(context).topSeller,
                        //     maxLines: 1,
                        //     overflow: TextOverflow.ellipsis,
                        //     style: CommonStyle.getAppFont(
                        //         color: CommonColors.color_515c6f,
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.w500),
                        //   ),
                        // ),
                    //mViewModel.experienceList.length > 0
                    // ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10,right: 15,left: 15),
                          child: Text(
                            S.of(context).topSeller,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: CommonStyle.getAppFont(
                                color: CommonColors.primaryBlack,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10,left: 10),
                          child: Icon(Icons.arrow_forward_ios,
                            color: CommonColors.color_9f9f9f,
                            size: 18.0,),
                        )
                      ],
                    ),
                    Container(
                      height: 290,
                      margin: EdgeInsets.only(bottom: 4, top: 4),
                      child: ListView.builder(
                          padding: EdgeInsets.only(
                              top: 10, left: 0, right: 0, bottom: 10),
                          itemCount: mViewModel.topSellerList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext buildContext, int index) {
                            return InkWell(
                              onTap: () {
                                print("top seller");
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                            Duration(seconds: 1),
                                        pageBuilder: (_, __, ___) =>
                                            ProductDetailsView(
                                              productId: mViewModel
                                                  .topSellerList[index]
                                                  .prouductId
                                                  .toString(),
                                            )));
                              },
                              child: TopSellerItemView(
                                position: index,
                                isLoggedIn: mViewModel.loginDetails != null,
                                productData: mViewModel.topSellerList[index],
                              ),
                            );
                          }),
                    )
                    //: Container()
                  ],
                ),
              )
            : Container()
        : ShimmerHorizontalList();

    final layoutPopularProducts = !mViewModel.isPopularProductsLoading
        ? mViewModel.popularProductList.length > 0
            ? Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                        // Container(
                        //   margin: EdgeInsets.only(left: 20, right: 20),
                        //   child: Text(
                        //     S.of(context).popularProduct,
                        //     maxLines: 1,
                        //     overflow: TextOverflow.ellipsis,
                        //     style: CommonStyle.getAppFont(
                        //         color: CommonColors.color_515c6f,
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.w500),
                        //   ),
                        // ),
                    //mViewModel.experienceList.length > 0
                    // ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0,left: 15,right: 15),
                          child: Text(
                            S.of(context).popularProduct,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: CommonStyle.getAppFont(
                                color: CommonColors.primaryBlack,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10,left: 10),
                          child: Icon(Icons.arrow_forward_ios,
                            color: CommonColors.color_9f9f9f,
                            size: 18.0,),
                        )
                      ],
                    ),
                    Container(
                      height: 290,
                      margin: EdgeInsets.only(bottom: 4, top: 4),
                      child: ListView.builder(
                          padding: EdgeInsets.only(
                              top: 10, left: 0, right: 0, bottom: 10),
                          itemCount: mViewModel.popularProductList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext buildContext, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                            Duration(seconds: 1),
                                        pageBuilder: (_, __, ___) =>
                                            ProductDetailsView(
                                              productId: mViewModel
                                                  .popularProductList[index]
                                                  .prouductId
                                                  .toString(),
                                            )));
                              },
                              child: TopSellerItemView(
                                position: index,
                                isLoggedIn: mViewModel.loginDetails != null,
                                productData: mViewModel.popularProductList[index],
                              ),
                            );
                          }),
                    )
                    //: Container()
                  ],
                ),
              )
            : Container()
        : ShimmerHorizontalList();


    final Searchbar = Row(
        children: [
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
              height: 50,
              padding: EdgeInsets.only(left: 20, right:20, top: 5, bottom: 5),
              decoration: BoxDecoration(
              color: CommonColors.white,
              borderRadius: BorderRadius.all(Radius.circular(25)
              ),
                boxShadow: [BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
              ),]
              ),
              child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                    //child: Image.asset(LocalImages.ic_search),
                  child: Icon(Icons.search),
               ),
                 Flexible(
                  child: Container(
                    child: TextField(
                      enabled: false,
                    decoration: InputDecoration(
                    //hintText: S.of(context).searchForProducts,
                      hintText: S.of(context).what,
                    hintStyle: CommonStyle.getAppFont(
                    color: CommonColors.color_9f9f9f,
                    fontWeight: FontWeight.w400,
                        fontSize: 16.0),
                          contentPadding:
                   // EdgeInsets.only(left: 20, right: 20,top: 10, bottom: Platform.isAndroid ? mViewModel.languageCode == AppConstants.LANGUAGE_ARABIC ? 8 : 14 : 14),
                          EdgeInsets.only( right: 20,top: 5, bottom: Platform.isAndroid ? mViewModel.languageCode == AppConstants.LANGUAGE_ARABIC ? 8 : 14 : 14),
                          border: InputBorder.none,
                    ),
                    style: CommonStyle.getAppFont(
                    color: CommonColors.dark_6060,
                    fontWeight: FontWeight.w400,
                     fontSize: 16.0),
                    maxLines: 1,
                    autocorrect: false,
                  ),
                 )
                 ),
               /* Icon(Icons.camera_alt_outlined,size: 27,color: Colors.black,)*/
                ],
              ),
            ),
        ))
      ]
    );


    // return Scaffold(
    //   key: mViewModel.scaffoldkey,
    //   backgroundColor: CommonColors.white,
    //   body: Column(
    //     children: [
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           SizedBox(height: MediaQuery.of(context).padding.top,),
    //           //layoutAppBar,
    //           //CurrentLocationHeaderView(),
    //           StackAppbar
    //         ],
    //       ),
    //       Expanded(
    //         child: SingleChildScrollView(
    //           //padding: EdgeInsets.only(top: 110),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               layoutImages,
    //               layoutCategories,
    //               layoutOffers,
    //               //layoutDeals,
    //               layoutTopSeller,
    //               //layoutAdsImage,
    //               layoutPopularProducts,
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // ); // old


    return Scaffold(
      key:  scaffoldkey,
      backgroundColor: CommonColors.white,
      body:Column(
        children: [
      Container(
          height: 178,
        child: Stack(
          children: [
            Container(
              color: CommonColors.dark_6060,
              width: MediaQuery.of(context).size.width,
              height: 140.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15,top: 12,right: 15),
                    height: 90,
                    width: 90,
                    child: Image.asset(LocalImages.ic_amazon_logo,color: Colors.white,),
                  ),
                  mViewModel.isApiLoading
                      ? Container(
                        margin: EdgeInsets.only(right: 20,left: 20) ,
                        child: SpinKitRing(
                        color: CommonColors.white,
                        size: 30,
                        lineWidth: 4,
                  ),
                      )
                      : mViewModel.categoryList.length > 0
                      ? Container(
                    padding: EdgeInsets.only(top: 90),
                  )
                      : NoDataWidget(message: mViewModel.message),
                ],
              ),
            ),
            Positioned(
              top: 115.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                    children: [
                          Searchbar,
                          ]
                          ),
                         )
                        ),
                      ],
                    )
                  ),
          Expanded(
              child: SingleChildScrollView(
            //padding: EdgeInsets.only(top: 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    layoutCategories,
                    layoutTopSeller,
                    layoutPopularProducts,
              ],
            ),
          ),
          )
        ]
      ),
      );
  }
}
