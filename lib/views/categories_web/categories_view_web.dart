import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/categories/categories_view_model.dart';
import 'package:big_mart/views/categories/category_item.dart';
import 'package:big_mart/views/currect_location_header/current_location_header_view.dart';
import 'package:big_mart/views/home/home_view_model.dart';
import 'package:big_mart/views/product_list/product_list_view.dart';
import 'package:big_mart/views/product_list/product_list_view_web.dart';
import 'package:big_mart/views/search_product/search_product_view.dart';
import 'package:big_mart/widgets/no_data_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'category_item_web.dart';
import 'sub_category_view_web.dart';

class CategoriesViewWeb extends StatefulWidget {
  @override
  _CategoriesViewWebState createState() => _CategoriesViewWebState();
}

class _CategoriesViewWebState extends State<CategoriesViewWeb> {
  final globalKey = new GlobalKey();
  CategoriesViewModel mViewModel;
  var mItemView;
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

    final layoutAppBar = Container(
      height: 55,
      padding: EdgeInsets.only(left: 20, right: 20, top: 7.5, bottom: 7.5),
      color: CommonColors.primaryColor,
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
          margin: EdgeInsets.only(left: 16),
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
              Row(
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
              )
            ],
          ),
        ),
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
    final mSubCategotyView = ListTile(
        title: Flexible(
      child: Container(
        padding: EdgeInsets.only(bottom: 0),
        color: CommonColors.white,
        child: mViewModel.categoryList.length > 0
            ? SubCategoryView(
                categoryId: mViewModel
                    .categoryList[mViewModel.selectedCategoryIndex].categoriesId
                    .toString(),
                onSubCategoryClick: (String categoryId) {
                  AppPreferences().setFilter(null);
                  mItemView = ProductListViewWeb(categoryId: categoryId);
                  mViewModel.notifyListeners();
                  /*  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(seconds: 1),
                          pageBuilder: (_, __, ___) => ProductListViewWeb(
                                categoryId: categoryId,
                              )));*/
                },
              )
            : Container(),
      ),
    ));

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

                mViewModel.notifyListeners();
              },
              child: Theme(
                  data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                      accentColor: CommonColors.primaryColor,
                      toggleableActiveColor: CommonColors.primaryColor),
                  child: ExpansionTile(
                    title: CategoryItemViewWeb(
                      category: mViewModel.categoryList[index],
                    ),
                    onExpansionChanged: (value) {
                      mViewModel.selectedCategoryIndex = index;
                      mViewModel.notifyListeners();
                    },
                    children: [mSubCategotyView],
                  )));
        });

    final mTabView = Container(
      color: CommonColors.white,
      width: MediaQuery.of(context).size.width / 4.5,
      child: mTabList,
    );

    final mainRow = Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          mTabView,
          mItemView == null ? new Container() : mItemView,
        ],
      ),
    );

    return Scaffold(
      backgroundColor: CommonColors.white,
      body: Stack(
        children: [
          mViewModel.isApiLoading
              ? Center(
                  child: SpinKitRing(
                    color: CommonColors.primaryColor,
                    size: 40,
                    lineWidth: 4,
                  ),
                )
              : mViewModel.categoryList.length > 0
                  ? Container(
                      //padding: EdgeInsets.only(top: 90),
                      child: mainRow,
                    )
                  : NoDataWidget(message: mViewModel.message),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              /*  layoutAppBar,
              CurrentLocationHeaderView(),*/
            ],
          ),
        ],
      ),
    );
  }
}
