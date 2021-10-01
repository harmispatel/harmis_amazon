import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/order_details/order_details_view.dart';
import 'package:big_mart/views/order_details/order_details_view_web.dart';
import 'package:big_mart/widgets/no_data_widget.dart';
import 'package:big_mart/widgets/shimmer_view/shimmer_cart_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_orders_view_model.dart';
import 'order_item_view.dart';

class MyOrdersView extends StatefulWidget {
  @override
  _MyOrdersViewState createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {
  final globalKey = new GlobalKey<ScaffoldState>();
  MyOrdersViewModel mViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<MyOrdersViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.getMyOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<MyOrdersViewModel>(context);

    return Scaffold(
      key: globalKey,
      backgroundColor: CommonColors.color_f3f3f3,
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
                  padding: const EdgeInsets.only(left: 65, right: 100),
                  child: Text(
                    S.of(context).myOrders,
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
      body: Builder(
        builder: (context) {
          return Container(
            child: mViewModel.isApiLoading
                ? ShimmerCartList()
                : mViewModel.orderList.length > 0
                    ? Container(
                        child: ListView.builder(
                            padding: EdgeInsets.only(top: 10, bottom: 20),
                            shrinkWrap: true,
                            itemCount: mViewModel.orderList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return InkWell(
                                onTap: () {
                                  kIsWeb?
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          transitionDuration:
                                          Duration(seconds: 1),
                                          pageBuilder: (_, __, ___) =>
                                              OrderDetailsViewWeb(
                                                orderId: mViewModel
                                                    .orderList[index].orderId
                                                    .toString(),
                                              )))
                                      :
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          transitionDuration:
                                              Duration(seconds: 1),
                                          pageBuilder: (_, __, ___) =>
                                              OrderDetailsView(
                                                orderId: mViewModel
                                                    .orderList[index].orderId
                                                    .toString(),
                                              )));
                                },
                                child: OrderItemView(
                                  onTrackPressed: () {
                                    mViewModel.showTrackingSheet(
                                        context,
                                        mViewModel.orderList[index].orderId
                                            .toString());
                                  },
                                  orderDetails: mViewModel.orderList[index],
                                ),
                              );
                            }),
                      )
                    : NoDataWidget(message: mViewModel.message),
          );
        },
      ),
    );
  }
}
