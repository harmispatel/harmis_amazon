import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'current_location_header_view_model.dart';

class CurrentLocationHeaderView extends StatefulWidget {
  @override
  _CurrentLocationHeaderViewState createState() => _CurrentLocationHeaderViewState();
}

class _CurrentLocationHeaderViewState extends State<CurrentLocationHeaderView> {
  final globalKey = new GlobalKey();
  CurrentLocationHeaderViewModel mViewModel;
  double index = 0;
  String address = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<CurrentLocationHeaderViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.locationPermission(onAddress: (String address) {
        this.address = address;
        mViewModel.notifyListeners();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<CurrentLocationHeaderViewModel>(context);
    return Container(
      color: CommonColors.color_4a9b6f,
      padding: EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
      child: Row(
        children: [
          Container(
            height: 22,
            width: 14,
            child: Image.asset(LocalImages.ic_location_white),
          ),
          SizedBox(width: 12,),
          Flexible(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        address.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: CommonStyle.getAppFont(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: CommonColors.white),
                      ),
                    ),
                    /*Text(
                      S.of(context).change,
                      style: CommonStyle.getAppFont(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: CommonColors.white),
                    ),*/
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
