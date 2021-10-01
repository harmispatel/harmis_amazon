import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/order_master.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/invoice_summary/invoice_summary_view_model.dart';
import 'package:big_mart/widgets/shimmer_view/shimmer_cart_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/common_colors.dart';
import '../../utils/text_style.dart';

class InvoiceSummaryView extends StatefulWidget {
  String orderId;

  InvoiceSummaryView({this.orderId});

  @override
  _InvoiceSummaryViewState createState() => _InvoiceSummaryViewState();
}

class _InvoiceSummaryViewState extends State<InvoiceSummaryView> {
  final globalKey = new GlobalKey();
  InvoiceSummaryViewModel mViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<InvoiceSummaryViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.getInvoiceDetails(widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<InvoiceSummaryViewModel>(context);

    if (mViewModel.invoiceDetails != null) {
      final btnSendInvoice = InkWell(
        onTap: () {
          mViewModel.sendInvoice(orderId: widget.orderId);
        },
        child: Container(
          margin: EdgeInsets.only(
              top: 12, left: 20.0, right: 20.0, bottom: 20.0),
          height: 50,
          decoration: BoxDecoration(
              color: Colors.orangeAccent.withOpacity(.9),
              borderRadius: BorderRadius.all(Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ]),
          child: Center(
            child: Text(
              S.of(context)
                  .sendInvoice,
              style: CommonStyle.getAppFont(
                  color: CommonColors.white,
                  fontSize: 18,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      );

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
                    padding: const EdgeInsets.only(left: 50, right: 65),
                    child: Text(
                      S.of(context)
                          .invoiceSummary,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              getInvoiceTotalCard(),
              getUserProfileCard(),
              getAddressCard(),
              getItemsCard(),
              btnSendInvoice
            ],
          ),
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
                    padding: const EdgeInsets.only(left: 50, right: 65),
                    child: Text(
                      S.of(context)
                          .invoiceSummary,
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

  Widget getInvoiceTotalCard() {
    final tvTotal = Text(
      mViewModel.invoiceDetails.subTotal.toString() + " IQ",
      style: CommonStyle.getAppFont(
        color: CommonColors.color_515c6f,
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
      ),
    );

    final tvDate = Text(
      mViewModel.invoiceDetails.orderDate.toString(),
      style: CommonStyle.getAppFont(
        color: CommonColors.color_515c6f,
        fontWeight: FontWeight.bold,
        fontSize: 22.0,
      ),
    );

    final totalColumn = Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getCardLabel(labelValue: S.of(context).invoiceTotal),
          SizedBox(
            height: 10.0,
          ),
          tvTotal
        ],
      ),
      flex: 1,
    );

    final dateColumn = Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          getCardLabel(labelValue: S.of(context).dueDate),
          SizedBox(
            height: 10.0,
          ),
          tvDate
        ],
      ),
      flex: 1,
    );

    final totalRow = Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1.0,
            offset: Offset.zero,
            blurRadius: 1.0)
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [totalColumn, dateColumn],
      ),
    );
    return totalRow;
  }

  Widget getCardLabel({labelValue}) {
    return Text(
      labelValue,
      style: CommonStyle.getAppFont(
        color: CommonColors.color_515c6f,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    );
  }

  Widget getUserProfileCard() {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1.0,
            offset: Offset.zero,
            blurRadius: 1.0)
      ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getCardLabel(labelValue: S.of(context).customerprofile),
          SizedBox(
            height: 25.0,
          ),
          getItemRow(
            label: S.of(context).name,
            value: mViewModel.invoiceDetails.shipTo.toString(),
          ),
          getItemRow(
            label: S.of(context).email,
            value: mViewModel.invoiceDetails.email.toString(),
          ),
          getItemRow(
            label: S.of(context).phoneNo,
            value: mViewModel.invoiceDetails.phoneNo.toString(),
          )
        ],
      ),
    );
  }

  Widget getAddressCard() {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1.0,
            offset: Offset.zero,
            blurRadius: 1.0)
      ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getCardLabel(labelValue: S.of(context).customerAddress),
          SizedBox(
            height: 25.0,
          ),
          Text(
            mViewModel.invoiceDetails.deliveredTo.toString(),
            style: CommonStyle.getAppFont(
              color: CommonColors.color_9f9f9f,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget getItemsCard() {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1.0,
            offset: Offset.zero,
            blurRadius: 1.0)
      ]),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCardLabel(labelValue: S.of(context).items),
            SizedBox(
              height: 20.0,
            ),
            ListView.builder(
                padding: EdgeInsets.only(top: 0, bottom: 0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: mViewModel.invoiceDetails.product.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext ctxt, int index) {
                  OrderProduct product = mViewModel.invoiceDetails.product[index];
                  /*Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: Duration(seconds: 1),
                            pageBuilder: (_, __, ___) => ProductDetailsView()));*/
                  return getProductItem(
                    label: product.productName,
                    value: product.productPrice.toString() + " IQ",
                    qty: product.productQty.toString() + " X " + product.productPrice.toString(),
                  );
                }),
            Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 20.0),
              height: 0.5,
              width: MediaQuery.of(context).size.width,
              color: CommonColors.color_dddddd,
            ),
            getTotalItemRow(
                label: S.of(context).subTotal,
                value: mViewModel.invoiceDetails.subTotal.toString() + " IQ"),
            //getTotalItemRow(label: "Tax(7%)", value: "7 IQ"),
          ]),
    );
  }

  Widget getItemRow({label, value}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: CommonStyle.getAppFont(
                color: CommonColors.color_9f9f9f,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
            Text(
              value,
              textAlign: TextAlign.end,
              style: CommonStyle.getAppFont(
                color: CommonColors.color_515c6f,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 15.0, bottom: 20.0),
          height: 0.5,
          width: MediaQuery.of(context).size.width,
          color: CommonColors.color_dddddd,
        )
      ],
    );
  }

  Widget getTotalItemRow({label, value}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: CommonStyle.getAppFont(
                color: CommonColors.color_9f9f9f,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
            Text(
              value,
              textAlign: TextAlign.end,
              style: CommonStyle.getAppFont(
                color: CommonColors.color_515c6f,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
          height: 0.5,
          width: MediaQuery.of(context).size.width,
        )
      ],
    );
  }

  Widget getProductItem({label, value, qty}) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: CommonStyle.getAppFont(
                    color: CommonColors.color_9f9f9f,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Text(
                value,
                textAlign: TextAlign.end,
                style: CommonStyle.getAppFont(
                  color: CommonColors.color_515c6f,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            qty,
            style: CommonStyle.getAppFont(
              color: CommonColors.color_9f9f9f,
              fontWeight: FontWeight.normal,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
