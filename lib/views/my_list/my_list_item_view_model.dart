import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/cart_master.dart';
import 'package:big_mart/models/message.dart';
import 'package:big_mart/models/product_master.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyListItemViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode, deviceToken;
  LoginDetails loginDetails;

  void attachContext(BuildContext context) {
    mContext = context;
  }

  void addRemoveFromWishList(
      {String productId, bool isAdd, Function onSuccess}) async {
    CommonUtils.showProgressDialog(mContext);
    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    if (loginDetails != null) {
      MessageMaster master = await _services.addRemoveFromWishlist(
        languageCode: languageCode,
        userId: loginDetails != null ? loginDetails.customerId.toString() : "",
        productId: productId,
        isType: isAdd ? "1" : "0",
      );
      if (master != null) {
        if (master.success == 1) {
          //CommonUtils.showGreenToastMessage(master.message.toString());
          onSuccess();
        } else {
          CommonUtils.showRedToastMessage(master.message.toString());
        }
      }
    }
    CommonUtils.hideProgressDialog(mContext);
    notifyListeners();
  }

  void addToCart({String productId}) async {
    CommonUtils.showProgressDialog(mContext);
    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    deviceToken = await appPreferences.getDeviceToken();

    MessageMaster master = await _services.addToCart(
      languageCode: languageCode,
      customerId: loginDetails != null ? loginDetails.customerId.toString() : "",
      productId: productId,
      deviceId: deviceToken,
    );
    if (master != null) {
      if (master.success == 1) {
        CommonUtils.showGreenToastMessage(master.message.toString());
        Provider.of<BottomNavBarViewModel>(mContext, listen: false)
            .getCartList();
      } else {
        CommonUtils.showRedToastMessage(master.message.toString());
      }
    }
    CommonUtils.hideProgressDialog(mContext);
    notifyListeners();
  }
}
