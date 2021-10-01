import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/models/track_order_model.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:flutter/material.dart';

class OrderTrackViewModel extends ChangeNotifier {
  List<TrackOrderDetails> listTrack = [];
  Services services = new Services();
  BuildContext mContext;
  String languageCode = "en";
  AppPreferences appPreferences = new AppPreferences();
  bool isApiLoading = true;

  Future<void> attachContext(BuildContext context, String orderId) async {
    mContext = context;
    listTrack.clear();
    languageCode = await appPreferences.getLanguageCode();
    loginApi(orderId: orderId);
    notifyListeners();
  }

  void loginApi({String orderId}) async {
    isApiLoading = true;
    notifyListeners();
    TrackOrderMaster master = await services.getOrderTrackList(
        languageCode: languageCode ?? "en", orderId: orderId);

    isApiLoading = false;
    notifyListeners();

    if (master != null) {
      if (master.success == 1) {
        listTrack.addAll(master.result);
        notifyListeners();
      } else {
        CommonUtils.showRedToastMessage(master.message.toString());
      }
    }
  }
}

class TrackModel {
  String status;
  String date;
  String time;
  String address;

  TrackModel(this.status, this.date, this.time, this.address);
}
