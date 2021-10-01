import 'dart:io';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/product_master.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/product_detail/product_details_view.dart';
import 'package:big_mart/views/product_detail/product_details_view_web.dart';
import 'package:big_mart/views/product_list/product_list_item.dart';
import 'package:big_mart/views/product_list/product_list_item_web.dart';
import 'package:big_mart/widgets/no_data_widget.dart';
import 'package:big_mart/widgets/shimmer_view/shimmer_cart_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'search_product_view_model.dart';

class SearchProductView extends StatefulWidget {
  @override
  _SearchProductViewState createState() => _SearchProductViewState();
}

class _SearchProductViewState extends State<SearchProductView> {
  final globalKey = new GlobalKey();
  SearchProductViewModel mViewModel;
  TextEditingController mSearchController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<SearchProductViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.getProductList();
    });
  }

  @override
  void dispose() {
    mSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SearchProductViewModel>(context);

    final layoutAppBar = Container(
      height: 55,
      padding: EdgeInsets.only(left: 5, right: 20, top: 7.5, bottom: 7.5),
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
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 40,
                // margin: EdgeInsets.only(left: 16),
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 5),
                decoration: BoxDecoration(
                    color: CommonColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: [
                     Icon(Icons.search,color: CommonColors.dark_6060,),

                    Flexible(
                        child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            cursorColor: Colors.black,
                            enabled: true,
                            autofocus: true,
                            onChanged: (keyword) {
                              print("search: " + keyword.toString());
                              mViewModel.page = 0;
                              mViewModel.totalCount = 0;
                              mViewModel.searchKeyword = keyword.toString();
                              mViewModel.getProductList();
                            },
                            controller: mSearchController,
                            decoration: InputDecoration(
                              hintText: S.of(context).searchForProducts,
                              hintStyle: CommonStyle.getAppFont(
                                  color: CommonColors.color_515c6f,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.0),
                              contentPadding: /*EdgeInsets.only(
                                  left: 20, right: 20, bottom: 14),*/
                              EdgeInsets.only( right: 15,left:15,bottom: Platform.isAndroid ? mViewModel.languageCode == AppConstants.LANGUAGE_ARABIC ? 8 : 14 : 14),
                              border: InputBorder.none,
                            ),
                            style: CommonStyle.getAppFont(
                                color: CommonColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0),
                            maxLines: 1,
                            autocorrect: false,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            mSearchController.text = "";
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            margin: EdgeInsets.only(bottom: 4,right: 10,left: 10),
                            child: Icon(
                              Icons.cancel,
                              color: CommonColors.dark_6060,
                            ),
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

    final layoutProductList = mViewModel.isApiLoading && mViewModel.page == 0
        ? ShimmerCartList()
        : mViewModel.productList.length > 0
            ? Container(
                padding: EdgeInsets.only(top: 0),
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: (mViewModel.isApiLoading)
                        ? mViewModel.productList.length + 1
                        : mViewModel.productList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return mViewModel.page > 0 &&
                              mViewModel.isApiLoading &&
                              index == mViewModel.productList.length
                          ? CommonUtils.getListItemProgressBar()
                          : InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                            Duration(seconds: 1),
                                        pageBuilder: (_, __, ___) =>
                                            ProductDetailsView(
                                              productId: mViewModel
                                                  .productList[index].prouductId
                                                  .toString(),
                                            )));
                              },
                              child: ProductListItemView(
                                productData: mViewModel.productList[index],
                                isLoggedIn: mViewModel.loginDetails != null,
                              ),
                            );
                    }),
              )
            : NoDataWidget(message: mViewModel.message);

    return Scaffold(
      key: mViewModel.scaffoldkey,
      backgroundColor: CommonColors.white,
      body: Stack(
        children: [
          NotificationListener(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top +
                        AppBar().preferredSize.height,
                  ),
                  layoutProductList,
                ],
              ),
            ),
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                print("Scrolled");
                if (mViewModel.productList.length < mViewModel.totalCount &&
                    !mViewModel.isApiLoading) {
                  mViewModel.page += 1;
                  mViewModel.isApiLoading = true;
                  mViewModel.notifyListeners();
                  mViewModel.getProductList();
                }
              }
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              layoutAppBar,
            ],
          ),
        ],
      ),
    );
  }
}
