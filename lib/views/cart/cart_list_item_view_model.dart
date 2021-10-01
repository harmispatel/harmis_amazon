import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/models/cart_message_master.dart';
import 'package:big_mart/models/message.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:flutter/cupertino.dart';

class CartListItemViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode;
  LoginDetails loginDetails;

  void attachContext(BuildContext context) {
    mContext = context;
  }

  void addRemoveFromWishList({String productId, bool isAdd, Function onSuccess}) async {
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
          CommonUtils.showGreenToastMessage(master.message.toString());
          onSuccess();
        }
        else
          {
          CommonUtils.showRedToastMessage(master.message.toString());
        }
      }
    }
    CommonUtils.hideProgressDialog(mContext);
    notifyListeners();
  }
}