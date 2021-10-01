import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/product_master.dart';
import 'package:big_mart/services/api_url.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/currect_location_header/current_location_header_view.dart';
import 'package:big_mart/views/home/deals_item.dart';
import 'package:big_mart/views/home/home_category_item_view.dart';
import 'package:big_mart/views/home/home_view_model.dart';
import 'package:big_mart/views/home/offers_item.dart';
import 'package:big_mart/views/home/top_seller_item.dart';
import 'package:big_mart/views/product_detail/product_details_view.dart';
import 'package:big_mart/views/product_detail/product_details_view_web.dart';
import 'package:big_mart/views/product_list/product_list_view.dart';
import 'package:big_mart/views/search_product/search_product_view.dart';
import 'package:big_mart/widgets/shimmer_view/shimmer_banner.dart';
import 'package:big_mart/widgets/shimmer_view/shimmer_horizontal_list.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'home_category_item_view_web.dart';

class HomeViewWeb extends StatefulWidget {
  @override
  _HomeViewWebState createState() => _HomeViewWebState();
}

class _HomeViewWebState extends State<HomeViewWeb> {
  final globalKey = new GlobalKey();
  HomeViewModel mViewModel;
  double index = 0;
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  final _boxHeight = 320.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachContext(context);
      mViewModel.getLoginDetails();
      mViewModel.getBannerList();
      mViewModel.initCategoryList();
      mViewModel.getOfferProductList();
      mViewModel.getDealsProductList();
      mViewModel.getTopSellerList();
      mViewModel.getPopularProductList();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<HomeViewModel>(context);

    final layoutAppBar = Container(
      height: 55,
      padding: EdgeInsets.only(left: 20, right: 20),
      color: CommonColors.primaryColor,
      child: Row(
        children: [
          SizedBox(
            width: 16,
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
              padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
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
                            EdgeInsets.only(left: 20, right: 20, bottom: 14),
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
            ? Container(
                height: 320,
                width: MediaQuery.of(context).size.width,
                child: _buildBody())
/*                  Container(
                      height: 300,
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
                          print('page chagned: ' + pageIndex.toString());
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
                  ),*/
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
                                            ProductDetailsViewWeb(
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
            height: 200,
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
                margin: EdgeInsets.only(bottom: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        S.of(context).categories,
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
                      height: 200,
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
                                            ProductListView(
                                              categoryId: mViewModel
                                                  .categoryList[index]
                                                  .categoriesId
                                                  .toString(),
                                            )));
                              },
                              child: HomeCategoryItemViewWeb(
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
                  bottom: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        S.of(context).topSeller,
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
                          itemCount: mViewModel.topSellerList.length,
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
                                            ProductDetailsViewWeb(
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
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        S.of(context).popularProduct,
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
                                            ProductDetailsViewWeb(
                                              productId: mViewModel
                                                  .popularProductList[index]
                                                  .prouductId
                                                  .toString(),
                                            )));
                              },
                              child: TopSellerItemView(
                                position: index,
                                isLoggedIn: mViewModel.loginDetails != null,
                                productData:
                                    mViewModel.popularProductList[index],
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

    return Scaffold(
      key: mViewModel.scaffoldkey,
      backgroundColor: CommonColors.white,
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              //layoutAppBar,
              // CurrentLocationHeaderView(),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              //padding: EdgeInsets.only(top: 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  layoutImages,
                  layoutCategories,
                  layoutOffers,
                  //layoutDeals,
                  layoutTopSeller,
                  layoutAdsImage,
                  layoutPopularProducts,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildBody() => ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          ArrowPageIndicator(
            isJump: true,
            isInside: true,
            leftIcon: Icon(
              Icons.arrow_back_ios,
              size: 40,
            ),
            rightIcon: Icon(
              Icons.arrow_forward_ios,
              size: 40,
            ),
            pageController: _pageController,
            currentPageNotifier: _currentPageNotifier,
            itemCount: mViewModel.bannerList.length,
            child: _buildPageView(_pageController, _currentPageNotifier),
          ),
          /*Text(''),
          ArrowPageIndicator(
            iconPadding: EdgeInsets.symmetric(horizontal: 16.0),
            isInside: true,
            leftIcon: Image.asset(
              "assets/images/left_arrow.png",
              width: 46.0,
              height: 46.0,
            ),
            rightIcon: Image.asset(
              "assets/images/right_arrow.png",
              width: 46.0,
              height: 46.0,
            ),
            */ /* rightIcon: Icon(
              Icons.arrow_right,
              color: Colors.white,
              size: 90.0,
            ),
            leftIcon: Icon(
              Icons.arrow_left,
              color: Colors.white,
              size: 90.0,
            ),*/ /*
            pageController: _pageController2,
            currentPageNotifier: _currentPageNotifier2,
            itemCount: mViewModel.bannerList.length,
            child: _buildPageView(_pageController2, _currentPageNotifier2),
          ),*/
        ]
            .map((item) => Padding(
                  child: item,
                  padding: EdgeInsets.all(0),
                ))
            .toList(),
      );

  _buildPageView(
          PageController pageController, ValueNotifier currentPageNotifier) =>
      Container(
        color: Colors.black,
        height: _boxHeight,
        width: MediaQuery.of(context).size.width,
        child: PageView.builder(
            itemCount: mViewModel.bannerList.length,
            controller: pageController,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                mViewModel.bannerList[index].slidersImg,
                fit: BoxFit.fill,
              );
            },
            onPageChanged: (int index) {
              currentPageNotifier.value = index;
            }),
      );
}
