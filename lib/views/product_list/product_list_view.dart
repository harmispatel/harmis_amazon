import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/product_master.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/currect_location_header/current_location_header_view.dart';
import 'package:big_mart/views/filter_dialog/filter_view.dart';
import 'package:big_mart/views/product_detail/product_details_view.dart';
import 'package:big_mart/views/product_list/product_list_item.dart';
import 'package:big_mart/views/search_product/search_product_view.dart';
import 'package:big_mart/widgets/no_data_widget.dart';
import 'package:big_mart/widgets/shimmer_view/shimmer_cart_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_list_view_model.dart';

class ProductListView extends StatefulWidget {
  String categoryId;

  ProductListView({this.categoryId});

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final globalKey = new GlobalKey();
  ProductListViewModel mViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<ProductListViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.categoryId = widget.categoryId ?? "";
      mViewModel.getProductList();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<ProductListViewModel>(context);
    print(mViewModel.productList.length.toString());

    final layoutAppBar = Container(
      height: 55,
      padding: EdgeInsets.only(left: 8, right: 20, top: 7.5, bottom: 7.5),
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
              /*  padding:
                    EdgeInsets.only(left: 20, right: 20,bottom: 14),*/
                decoration: BoxDecoration(
                    color: CommonColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 20,top: 2),
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
                                  color: CommonColors.color_515c6f,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.0),
                              contentPadding: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 8),
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

    final layoutResults = Container(
      padding: EdgeInsets.only(left: 20, right: 15, top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: CommonColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            mViewModel.totalCount.toString() + " " + S.of(context).results,
            style: CommonStyle.getAppFont(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: CommonColors.color_515c6f),
          ),
          Row(
            children: [
              /*InkWell(
                  onTap: () {
                    print("Grid view");
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    child: Icon(
                      Icons.grid_view,
                      color: CommonColors.color_515c6f,
                    ),
                  )),*/
              SizedBox(
                width: 6,
              ),
              InkWell(
                  onTap: () {
                    print("Filter view");
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext bc) {
                          return FilterView();
                        }).then((value) {
                      if (value != null) {
                        var result = value as Map;
                        if (result.containsKey(AppConstants.FILTERS)) {
                          print("apply filter");
                          mViewModel.page = 0;
                          mViewModel.totalCount = 0;
                          mViewModel.productList.clear();
                          mViewModel.notifyListeners();
                          mViewModel.getProductList();
                        }
                      }
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    child: Icon(
                      Icons.filter_alt_outlined,
                      color: CommonColors.color_515c6f,
                    ),
                  )),
            ],
          )
        ],
      ),
    );

    final layoutProductList = mViewModel.isApiLoading && mViewModel.page == 0
        ? ShimmerCartList()
        : mViewModel.productList.length > 0
            ? NotificationListener(
                child: Container(
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
                                                    .productList[index]
                                                    .prouductId
                                                    .toString(),
                                              )));
                                },
                                child: ProductListItemView(
                                  productData: mViewModel.productList[index],
                                  isLoggedIn: mViewModel.loginDetails != null,
                                ),
                              );
                      }),
                ),
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                    if (mViewModel.productList.length < mViewModel.totalCount &&
                        !mViewModel.isApiLoading) {
                      mViewModel.page += 1;
                      mViewModel.isApiLoading = true;
                      mViewModel.notifyListeners();
                      mViewModel.getProductList();
                    }
                  }
                },
              )
            : NoDataWidget(message: mViewModel.message);

    return Scaffold(
      key: mViewModel.scaffoldkey,
      backgroundColor: CommonColors.white,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top +
                    AppBar().preferredSize.height +
                    10,
              ),
              Expanded(child: layoutProductList),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              layoutAppBar,
              //CurrentLocationHeaderView(),
              layoutResults,
            ],
          ),
        ],
      ),
    );
  }
}
