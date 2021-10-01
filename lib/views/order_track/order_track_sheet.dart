import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/track_order_model.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'order_trick_view_model.dart';

class OrderTrackView extends StatefulWidget {
  Function onClosePressed;
  String orderId;

  OrderTrackView({this.onClosePressed, this.orderId});

  @override
  _OrderTrackViewState createState() => _OrderTrackViewState();
}

class _OrderTrackViewState extends State<OrderTrackView> {
  OrderTrackViewModel mViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<OrderTrackViewModel>(context, listen: false);
      mViewModel.attachContext(context, widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<OrderTrackViewModel>(context);

    final topRow = Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).trackOrder,
            style: CommonStyle.getAppFont(
                color: CommonColors.dark_6060,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: widget.onClosePressed,
            child: Icon(
              Icons.close,
              color: CommonColors.lightGrey,
            ),
          )
        ],
      ),
    );

    final listview = ListView.builder(
      shrinkWrap: true,
      itemCount: mViewModel.listTrack.length,
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return getTrackItem(mViewModel.listTrack[index], index);
      },
    );

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
                color: CommonColors.lightGrey,
                offset: Offset.zero,
                spreadRadius: 1.0,
                blurRadius: 1.0)
          ]),
      height: 380,
      child: mViewModel.isApiLoading
          ? Center(
              child: CircularProgressIndicator(color: Colors.orangeAccent.withOpacity(.9),),
            )
          : SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [topRow, listview],
              ),
            ),
    );
  }

  Widget getTrackItem(TrackOrderDetails trackModel, int index) {
    var strArray = trackModel.date == null
        ? ["00/00", "00:00"]
        : trackModel.date.split(" ");

    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime dateTime;

    try {
      dateTime = formatter.parse(trackModel.date);
    } catch (e) {}

    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dateTime == null
                ? ("00/00 \n 00:00")
                : dateTime.day.toString() +
                    "/" +
                    dateTime.month.toString() +
                    "\n" +
                    dateTime.hour.toString() +
                    ":" +
                    dateTime.minute.toString(),
            style: CommonStyle.getAppFont(
                color: trackModel.isStatusComplete
                    ? CommonColors.primaryBlack
                    : CommonColors.lightGrey,
                fontSize: 10.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 25.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             /* Image.asset(
                trackModel.isStatusComplete
                    ? LocalImages.ic_radion_select
                    : LocalImages.ic_radio_unselect,
                height: 36.0,
                width: 36.0,
                fit: BoxFit.fill,
              ),*/
                Icon(
                trackModel.isStatusComplete
                ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                  size: 36,
                color: Colors.orangeAccent.withOpacity(.9),
                ),
              Visibility(
                  visible: index != mViewModel.listTrack.length - 1,
                  child: Container(
                    height: 30.0,
                    width: 1,
                    color: CommonColors.lightGrey,
                  ))
            ],
          ),
          SizedBox(
            width: 14.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                trackModel.status,
                style: CommonStyle.getAppFont(
                    color: trackModel.isStatusComplete
                        ? CommonColors.primaryBlack
                        : CommonColors.lightGrey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                trackModel.comments,
                style: CommonStyle.getAppFont(
                    color: CommonColors.lightGrey,
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
