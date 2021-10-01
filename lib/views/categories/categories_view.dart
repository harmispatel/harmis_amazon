import 'dart:io';
import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/categories/category_item.dart';
import 'package:big_mart/views/categories/sub_cat_view.dart';
import 'package:big_mart/views/currect_location_header/current_location_header_view.dart';
import 'package:big_mart/views/product_list/product_list_view.dart';
import 'package:big_mart/views/search_product/search_product_view.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar_view_model.dart';
import 'package:big_mart/widgets/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'categories_view_model.dart';
import 'sub_category_view.dart';

class CategoriesView extends StatefulWidget {
  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final globalKey = new GlobalKey();
  CategoriesViewModel mViewModel;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<CategoriesViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.initCategoryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<CategoriesViewModel>(context);

    // final layoutAppBar = Container(
    //   height: 55,
    //   padding: EdgeInsets.only(left: 20, right: 20, top: 7.5, bottom: 7.5),
    //   color: CommonColors.primaryColor,
    //   child: InkWell(
    //     onTap: () {
    //       Navigator.push(
    //           context,
    //           PageRouteBuilder(
    //               transitionDuration: Duration(seconds: 1),
    //               pageBuilder: (_, __, ___) => SearchProductView()));
    //     },
    //     child: Container(
    //       height: 40,
    //       margin: EdgeInsets.only(left: 16),
    //       padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
    //       decoration: BoxDecoration(
    //           color: CommonColors.white,
    //           borderRadius: BorderRadius.all(Radius.circular(20))),
    //       child: Row(
    //         children: [
    //           Container(
    //             height: 11,
    //             width: 11,
    //             child: Image.asset(LocalImages.ic_search),
    //           ),
    //           Flexible(
    //               child: Row(
    //             children: [
    //               Flexible(
    //                 child: TextField(
    //                   enabled: false,
    //                   decoration: InputDecoration(
    //                     hintText: S.of(context).searchForProducts,
    //                     hintStyle: CommonStyle.getAppFont(
    //                         color: CommonColors.color_515c6f,
    //                         fontWeight: FontWeight.w400,
    //                         fontSize: 15.0),
    //                     contentPadding:
    //                         EdgeInsets.only(left: 20, right: 20, bottom: Platform.isAndroid ? mViewModel.languageCode == AppConstants.LANGUAGE_ARABIC ? 8 : 14 : 14),
    //                     border: InputBorder.none,
    //                   ),
    //                   style: CommonStyle.getAppFont(
    //                       color: CommonColors.primaryColor,
    //                       fontWeight: FontWeight.w400,
    //                       fontSize: 16.0),
    //                   maxLines: 1,
    //                   autocorrect: false,
    //                 ),
    //               ),
    //               kIsWeb
    //                   ? new Container()
    //                   : InkWell(
    //                       onTap: () {
    //                         // mViewModel.startBarcode();
    //                         CommonUtils.scanBarcodeNormal(context);
    //                       },
    //                       child: Container(
    //                         height: 16,
    //                         width: 20,
    //                         child: Image.asset(LocalImages.ic_scan),
    //                       ),
    //                     ),
    //             ],
    //           ))
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    final layoutAppBar = Container(
        height: 55,
        padding: EdgeInsets.only(left:5,right: 20, top: 7.5, bottom: 7.5),
        color: CommonColors.dark_6060,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Provider.of<BottomNavBarViewModel>(context,listen: false).changeTab(0);
                /*Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(
                      builder: (context) => bottomNavigationBar(),
                    ), (route) => false);*/
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
              child:InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(seconds: 1),
                          pageBuilder: (_, __, ___) => SearchProductView()));
                },
                child: Container(
                  height: 40,
                  //margin: EdgeInsets.only(left: 16),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: CommonColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 4),
                        child: Icon(Icons.search,color: CommonColors.dark_6060,),
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
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.0),
                                    contentPadding:
                                    EdgeInsets.only( right: 15,left:15,bottom: Platform.isAndroid ? mViewModel.languageCode == AppConstants.LANGUAGE_ARABIC ? 8 :8 :14),
                                    /*EdgeInsets.symmetric(vertical: 9.0,horizontal: 16.0),*/
                                    border: InputBorder.none,
                                  ),
                                  style: CommonStyle.getAppFont(
                                      color: CommonColors.dark_6060,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0),
                                  maxLines: 1,
                                  autocorrect: false,
                                ),
                              ),
                             /* kIsWeb
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
                              ),*/
                            ],
                          ))
                    ],
                  ),
                ),
              ), )
          ],
        )
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

    final mTabList = ListView.builder(
        shrinkWrap: true,
        itemCount: mViewModel.categoryList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext ctxt, int index) {
          return InkWell(
            onTap: () {
              for (int i = 0; i < mViewModel.categoryList.length; i++) {
                mViewModel.categoryList[i].isSelected = false;
              }
              mViewModel.categoryList[index].isSelected = true;
              mViewModel.selectedCategoryIndex = index;
              mViewModel.notifyListeners();
            },
            child: CategoryItemView(
              category: mViewModel.categoryList[index],
            ),
          );
        });

    final   mtabview = Container(
      margin: EdgeInsets.only(left: 8,right: 8),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.71,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            crossAxisSpacing:10,
          ),
          itemCount: mViewModel.categoryList.length,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(seconds: 1),
                        pageBuilder: (_, __, ___) => SubCategory(catId: mViewModel.categoryList[index].categoriesId,
                        )));
                },
              child: Container(
                height: 160,
                child: Card(
                  elevation: 1.5,
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 159,
                        child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                            child: Image.network(mViewModel.categoryList[index].categoriesImg,fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                    child: SpinKitRing(
                                      color: Colors.orangeAccent,
                                      size: 40,
                                      lineWidth: 4,
                                    )
                                );
                              },)),
                      ),
                      Container(
                         // color: CommonColors.dark_6060,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 13,right: 13),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8.0,8.0, 8.0, 2),
                            child: Text(mViewModel.categoryList[index].categoriesSlug,style: TextStyle(fontSize: 17),maxLines: 2,),
                          )),
                    ],
                  ),
                ),
              ),
            );
          }
      )
    );

    // final mTabView = Container(
    //   color: CommonColors.color_f3f3f3,
    //   width: MediaQuery.of(context).size.width / 3.4,
    //   child: mTabList,
    // );
    //
    // final mBodyView = Flexible(
    //   child: Container(
    //     padding: EdgeInsets.only(bottom: 0),
    //     color: CommonColors.white,
    //     child: mViewModel.categoryList.length > 0
    //         ? SubCategoryView(
    //             categoryId: mViewModel
    //                 .categoryList[mViewModel.selectedCategoryIndex].categoriesId
    //                 .toString(),
    //             onSubCategoryClick: (String categoryId) {
    //               AppPreferences().setFilter(null);
    //               Navigator.push(
    //                   context,
    //                   PageRouteBuilder(
    //                       transitionDuration: Duration(seconds: 1),
    //                       pageBuilder: (_, __, ___) => ProductListView(
    //                             categoryId: categoryId,
    //                           )));
    //             },
    //           )
    //         : Container(),
    //   ),
    // );
    //
    // final mainRow = Container(
    //   padding: EdgeInsets.only(top: 20.0),
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       mTabView,
    //       mBodyView,
    //     ],
    //   ),
    // );
    //
    // return Scaffold(
    //   backgroundColor: CommonColors.white,
    //   body: Stack(
    //     children: [
    //       mViewModel.isApiLoading
    //           ? Center(
    //               child: SpinKitRing(
    //                 color: CommonColors.primaryColor,
    //                 size: 40,
    //                 lineWidth: 4,
    //               ),
    //             )
    //           : mViewModel.categoryList.length > 0
    //               ? Container(
    //                   padding: EdgeInsets.only(top: 90),
    //                   child: mainRow,
    //                 )
    //               : NoDataWidget(message: mViewModel.message),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           SizedBox(
    //             height: MediaQuery.of(context).padding.top,
    //           ),
    //           layoutAppBar,
    //           CurrentLocationHeaderView(),
    //         ],
    //       ),
    //     ],
    //   ),
    // );

    return Scaffold(
      backgroundColor: CommonColors.white,
      body: Stack(
        children: [
          mViewModel.isApiLoading
              ? Center(
            child: SpinKitRing(
              color: Colors.orangeAccent,
              size: 40,
              lineWidth: 4,
            ),
          )
              : mViewModel.categoryList.length > 0
              ? Container(
            padding: EdgeInsets.only(top: 90),
            child: mtabview,
          )
              : NoDataWidget(message: mViewModel.message),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              layoutAppBar
            ],
          ),
        ],
      ),
    );
  }

}
