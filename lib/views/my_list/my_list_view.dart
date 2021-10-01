import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/categories/category_item.dart';
import 'package:big_mart/views/filter_dialog/filter_view.dart';
import 'package:big_mart/views/home/home_view_model.dart';
import 'package:big_mart/views/my_list/my_list_item.dart';
import 'package:big_mart/views/product_detail/product_details_view.dart';
import 'package:big_mart/views/product_detail/product_details_view_web.dart';
import 'package:big_mart/views/product_list/product_list_item.dart';
import 'package:big_mart/widgets/no_data_widget.dart';
import 'package:big_mart/widgets/shimmer_view/shimmer_cart_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_list_view_model.dart';

class MyListView extends StatefulWidget {
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  final globalKey = new GlobalKey();
  MyListViewModel mViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<MyListViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.getProductList();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<MyListViewModel>(context);

    /*return Scaffold(
      key: globalKey,
      backgroundColor: CommonColors.white,
      appBar: AppBar(
        backgroundColor: CommonColors.primaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.only(left: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    S.of(context).myList,
                    style: CommonStyle.getAppFont(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: CommonColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: mViewModel.isApiLoading
            ? ShimmerCartList()
            : mViewModel.productList.length > 0
                ? Container(
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 10, bottom: 20),
                        shrinkWrap: true,
                        itemCount: mViewModel.productList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      transitionDuration: Duration(seconds: 1),
                                      pageBuilder: (_, __, ___) =>
                                          ProductDetailsView(
                                              productId: mViewModel
                                                  .productList[index].prouductId
                                                  .toString())));
                            },
                            child: MyListItemView(
                              position: index,
                              productData: mViewModel.productList[index],
                            ),
                          );
                        }),
                  )
                : NoDataWidget(message: mViewModel.message),
      ),
    );*/

    return Scaffold(
      key: globalKey,
      backgroundColor: CommonColors.white,
      appBar: AppBar(
        backgroundColor: CommonColors.dark_6060,
        elevation: 0.0,
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.only(left: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 80, right: 100),
                  child: Text(
                    S.of(context).myList,
                    style: CommonStyle.getAppFont(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: CommonColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: mViewModel.isApiLoading
            ? ShimmerCartList()
            : mViewModel.productList.length > 0
            ? Container(
          child: ListView.builder(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              shrinkWrap: true,
              itemCount: mViewModel.productList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext ctxt, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: Duration(seconds: 1),
                            pageBuilder: (_, __, ___) =>
                                ProductDetailsView(
                                    productId: mViewModel
                                        .productList[index].prouductId
                                        .toString())));
                  },
                  child: MyListItemView(
                    position: index,
                    productData: mViewModel.productList[index],
                  ),
                );
              }),
        )
            : NoDataWidget(message: mViewModel.message),
      ),
    );
  }
}
