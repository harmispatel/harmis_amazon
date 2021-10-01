import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/models/order_master.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/views/order_track/order_track_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyOrdersViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode;
  List<OrderDetails> orderList = new List();
  bool isApiLoading = false;
  LoginDetails loginDetails;
  String message;

  void attachContext(BuildContext context) {
    mContext = context;
  }

  void getMyOrders() async {
    isApiLoading = true;
    orderList.clear();
    notifyListeners();

    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    OrderMaster master = await _services.orderList(
      languageCode: languageCode,
      customerId:
          loginDetails != null ? loginDetails.customerId.toString() : "",
    );
    isApiLoading = false;
    if (master != null) {
      if (master.success == 1) {
        if (master.result != null && master.result.length > 0) {
          orderList.addAll(master.result);
        }
      }
      else {
        message = master.message;
      }
    }
    notifyListeners();
  }

  void showTrackingSheet(BuildContext context, String orderId) {
    showModalBottomSheet(
        context: context,
        elevation: 5.0,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return OrderTrackView(
            orderId: orderId,
            onClosePressed: () {
              Navigator.pop(mContext);
            },
          );
        });
  }
}
