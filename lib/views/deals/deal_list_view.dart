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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'deal_list_view_model.dart';

class DealListView extends StatefulWidget {
  @override
  _DealListViewState createState() => _DealListViewState();
}

class _DealListViewState extends State<DealListView> {
  final globalKey = new GlobalKey();
  DealListViewModel mViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<DealListViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.getDealsProductList();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<DealListViewModel>(context);
    print(mViewModel.productList.length.toString());

    final layoutProductList = mViewModel.isApiLoading && mViewModel.page == 0
        ? ShimmerCartList()
        : mViewModel.productList.length > 0
            ? NotificationListener(
                child: Container(
                  padding: EdgeInsets.only(top: 0),
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 8, bottom: 20),
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
                    /*if (mViewModel.productList.length < mViewModel.totalCount &&
              !mViewModel.isApiLoading) {
            mViewModel.page += 1;
            mViewModel.isApiLoading = true;
            mViewModel.notifyListeners();
            mViewModel.getProductList();
          }*/
                  }
                },
              )
            : NoDataWidget(message: mViewModel.message);

    return Scaffold(
      key: mViewModel.scaffoldkey,
      backgroundColor: CommonColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
        title: Text(
          S.of(context).deals,
          style: CommonStyle.getAppFont(
              fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          CurrentLocationHeaderView(),
          Expanded(child: layoutProductList)
        ],
      ),
    );
  }
}
