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
import 'package:big_mart/views/categories/sub_category_view.dart';
import 'package:big_mart/views/categories/sub_category_view_model.dart';
import 'package:big_mart/views/currect_location_header/current_location_header_view.dart';
import 'package:big_mart/views/product_list/product_list_view.dart';
import 'package:big_mart/views/search_product/search_product_view.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar_view_model.dart';
import 'package:big_mart/widgets/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'categories_view_model.dart';

class SubCategory extends StatefulWidget {
  final int catId;
  SubCategory({this.catId});
  TextEditingController mSearchController = new TextEditingController();



  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  final globalKey = new GlobalKey();
  SubCategoryViewModel mViewModel;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<SubCategoryViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.initSubCategoryList(widget.catId.toString());
    });
  }



  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SubCategoryViewModel>(context);

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

    // final layoutAppBar = Container(
    //   height: 55,
    //   padding: EdgeInsets.only(left: 20, right: 20, top: 7.5, bottom: 7.5),
    //   color: CommonColors.dark_6060,
    //   child: Row(
    //     children: [
    //       IconButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               icon: Container(
    //                 height: 15,
    //                 child: Image.asset(
    //                   LocalImages.ic_arrow_back,
    //                   color: CommonColors.white,
    //                 ),
    //               ),
    //             ),
    //       InkWell(
    //         onTap: () {
    //           Navigator.push(
    //               context,
    //               PageRouteBuilder(
    //                   transitionDuration: Duration(seconds: 1),
    //                   pageBuilder: (_, __, ___) => SearchProductView()));
    //         },
    //         child: Padding(
    //           padding: const EdgeInsets.only(left: 5),
    //           child: Container(
    //             height: 40,
    //             margin: EdgeInsets.only(left: 16),
    //             padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
    //             decoration: BoxDecoration(
    //                 color: CommonColors.white,
    //                 borderRadius: BorderRadius.all(Radius.circular(20))),
    //             child: Row(
    //               children: [
    //                 Container(
    //                   height: 11,
    //                   width: 11,
    //                   child: Image.asset(LocalImages.ic_search,color: Colors.grey,),
    //                 ),
    //                 Flexible(
    //                     child: Row(
    //                       children: [
    //                         Flexible(
    //                           child: TextField(
    //                             enabled: false,
    //                             decoration: InputDecoration(
    //                               hintText: S.of(context).searchForProducts,
    //                               hintStyle: CommonStyle.getAppFont(
    //                                   fontWeight: FontWeight.w400,
    //                                   fontSize: 15.0),
    //                               contentPadding:
    //                               EdgeInsets.only(left: 20, right: 20, bottom: Platform.isAndroid ? mViewModel.languageCode == AppConstants.LANGUAGE_ARABIC ? 8 : 14 : 14),
    //                               border: InputBorder.none,
    //                             ),
    //                             style: CommonStyle.getAppFont(
    //                                 color: CommonColors.primaryColor,
    //                                 fontWeight: FontWeight.w400,
    //                                 fontSize: 16.0),
    //                             maxLines: 1,
    //                             autocorrect: false,
    //                           ),
    //                         ),
    //                         kIsWeb
    //                             ? new Container()
    //                             : InkWell(
    //                           onTap: () {
    //                             // mViewModel.startBarcode();
    //                             CommonUtils.scanBarcodeNormal(context);
    //                           },
    //                           child: Container(
    //                             height: 16,
    //                             width: 20,
    //                             child: Image.asset(LocalImages.ic_scan),
    //                           ),
    //                         ),
    //                       ],
    //                     ))
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    // final layoutAppBar = Container(
    //   height: 55,
    //   padding: EdgeInsets.only(left: 5, right: 20, top: 7.5, bottom: 7.5),
    //   color: CommonColors.dark_6060,
    //   child: Row(
    //     children: [
    //       IconButton(
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //         icon: Container(
    //           height: 15,
    //           child: Image.asset(
    //             LocalImages.ic_arrow_back,
    //             color: CommonColors.white,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );


    /*final layoutAppBar = Container(
      height: 55,
      padding: EdgeInsets.only(left:5,right: 20, top: 7.5, bottom: 7.5),
      color: CommonColors.dark_6060,
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
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  decoration: BoxDecoration(
                      color: CommonColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    children: [
                      Container(
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
                              ),
                             *//* kIsWeb
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
                              ),*//*
                            ],
                          ))
                    ],
                  ),
                ),
              ), )
        ],
      )
    );*/

    final layoutAppBar = Container(
        height: 55,
        padding: EdgeInsets.only(left:5,right: 20, top: 7.5, bottom: 7.5),
        color: CommonColors.dark_6060,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                /*Provider.of<BottomNavBarViewModel>(context,listen: false).changeTab(1);*/
                /*Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(
                      builder: (context) => bottomNavigationBar(),
                    ), (route) => false);*/
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



    final mtabview = Container(
        margin: EdgeInsets.only(left: 8,right: 8),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.69,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              crossAxisSpacing:10,
            ),
            itemCount: mViewModel.subCategoryList.length,
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                onTap: (){
                  AppPreferences().setFilter(null);
                                 Navigator.push(
                                     context,
                                     PageRouteBuilder(
                                         transitionDuration: Duration(seconds: 1),
                                         pageBuilder: (_, __, ___) => ProductListView(
                                               categoryId: mViewModel.subCategoryList[index].categoriesId.toString(),
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
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                            child: Image.network(mViewModel.subCategoryList[index].categoriesImg.contains('jpg')?mViewModel.subCategoryList[index].categoriesImg:"https://i.pinimg.com/originals/62/98/b0/6298b026a65cf80bcf9dce061e9b79c9.png",
                                fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                    child: SpinKitRing(
                                      color: Colors.orangeAccent,
                                      size: 40,
                                      lineWidth: 4,
                                    )
                                );
                              },),
                          ),
                        ),
                        Container(
                          // color: CommonColors.dark_6060,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 15,right: 15,top: 5),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(mViewModel.subCategoryList[index].categoriesSlug.toUpperCase(),
                                style: TextStyle(fontSize: 16),maxLines: 2,),
                            )),
                      ],
                    ),
                  ),
                ),
              );
            }
        )
    );


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
              : mViewModel.subCategoryList.length > 0
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
