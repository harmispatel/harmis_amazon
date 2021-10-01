import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/home/home_view.dart';
import 'package:big_mart/views/invoice_summary/invoice_summary_view.dart';
import 'package:big_mart/views/invoice_summary/invoice_summary_view_web.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/shimmer_view/shimmer_cart_list.dart';
import '../my_orders/order_product_item.dart';
import 'order_details_view_model.dart';

class OrderDetailsView extends StatefulWidget {
  String orderId;

  OrderDetailsView({this.orderId});

  @override
  _OrderDetailsViewState createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  final globalKey = new GlobalKey();
  OrderDetailsViewModel mViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<OrderDetailsViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.getOrderDetails(widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<OrderDetailsViewModel>(context);

    if (mViewModel.orderDetails != null) {
      final layoutBottom = true
          ? Container(
              padding: EdgeInsets.all(20),
              color: CommonColors.white,
              child: InkWell(
                onTap: () {
                  /*mViewModel.getOrderproducts(
                      mViewModel.orderDetails.orderId.toString());*/
                  // Navigator.push(context, MaterialPageRoute(builder: (context){return bottomNavigationBar()}));
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                     bottomNavigationBar()), (Route<dynamic> route) => false);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent.withOpacity(.9),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Center(
                    child: Text(
                      S.of(context).buyAgain.toUpperCase(),
                      style: CommonStyle.getAppFont(
                          color: CommonColors.white,
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            )
          : Container();

      return Scaffold(
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
                    padding: const EdgeInsets.only(left: 50, right: 70),
                    child: Text(
                      S.of(context).orderDetails,
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
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  mViewModel.orderDetails.product != null &&
                          mViewModel.orderDetails.product.length > 0
                      ? ListView.builder(
                          padding: EdgeInsets.only(top: 0, bottom: 0),
                          shrinkWrap: true,
                          itemCount: mViewModel.orderDetails.product.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext ctxt, int index) {
                            /*Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: Duration(seconds: 1),
                            pageBuilder: (_, __, ___) => ProductDetailsView()));*/
                            return OrderProductItemView(
                              product: mViewModel.orderDetails.product[index],
                            );
                          })
                      : Container(),
                  SizedBox(
                    height: 16,
                  ),
                  getCommonRow(S.of(context).orderId,
                      mViewModel.orderDetails.orderId.toString()),
                  getCommonRow(S.of(context).shipTo,
                      mViewModel.orderDetails.shipTo.toString()),
                  getCommonRow(S.of(context).orderDate,
                      mViewModel.orderDetails.orderDate.toString()),
                  getCommonRow(S.of(context).phoneNo,
                      mViewModel.orderDetails.phoneNo.toString()),
                  getCommonRow(S.of(context).email,
                      mViewModel.orderDetails.email.toString()),
                  InkWell(
                      onTap: () {
                        kIsWeb
                            ? Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return InvoiceSummaryViewWeb(
                                  orderId: widget.orderId,
                                );
                              }))
                            : Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                return InvoiceSummaryView(
                                  orderId: widget.orderId,
                                );
                              }));
                      },
                      child: getCommonRow(
                          S.of(context).invoice, S.of(context).view,
                          isInvoice: true)),
                  getCommonRow(S.of(context).deliveredTo,
                      mViewModel.orderDetails.deliveredTo.toString()),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: layoutBottom,
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: CommonColors.dark_6060,
          elevation: 0.0,
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          title: Container(
            padding: EdgeInsets.only(left: 4),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
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
                    padding: const EdgeInsets.only(left: 50, right: 70),
                    child: Text(
                      S.of(context).orderDetails,
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
        body: ShimmerCartList(),
      );
    }
  }

  Widget getCommonRow(String title, String value, {bool isInvoice = false}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 12, bottom: 12),
                child: Text(
                  title,
                  style: CommonStyle.getAppFont(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: CommonColors.color_515c6f),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 12, bottom: 12),
                  child: Text(
                    value,
                    style: CommonStyle.getAppFont(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: isInvoice
                            ? Colors.orangeAccent.withOpacity(.9)
                            : CommonColors.color_515c6f),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 1,
            color: CommonColors.color_f3f3f3,
          ),
        ],
      ),
    );
  }
}
