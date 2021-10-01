import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/models/cart_master.dart';
import 'package:big_mart/models/cart_message_master.dart';
import 'package:big_mart/models/message.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartListViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode, deviceToken;
  List<CartDetails> cartList = new List();
  bool isApiLoading = false;
  LoginDetails loginDetails;
  String message;
  String totalPrice = "0.0";

  Future<void> attachContext(BuildContext context) async {
    mContext = context;
  }

  void getCartList() async {
    cartList.clear();
    totalPrice = "0.0";
    isApiLoading = true;
    notifyListeners();

    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    deviceToken = await appPreferences.getDeviceToken();

      CartMaster master = await _services.getCartList(
        languageCode: languageCode,
        customerId:
            loginDetails != null ? loginDetails.customerId.toString() : "",
        deviceId: deviceToken
      );
      if (master != null) {
        if (master.success == 1) {
          if (master.result != null && master.result.length > 0) {
            totalPrice = master.totalprice;
            cartList.addAll(master.result);
          }
        } else {
          message = master.message;
        }
      }
    isApiLoading = false;
    notifyListeners();
  }

  double getTotalprice() {
    double cartTotal = 0.0;
    for (CartDetails cartDetails in cartList) {
      double finalPrice = double.parse(cartDetails.productPrice.replaceAll(",", "")) *
          cartDetails.customerBasketQuantity;
      cartTotal = cartTotal + finalPrice;
    }
    return cartTotal;
  }

  void addRemoveCartQuantity({int index, int action}) async {
    CommonUtils.showProgressDialog(mContext);
    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    deviceToken = await appPreferences.getDeviceToken();

      CartMessageMaster master = await _services.addRemoveFromCart(
        languageCode: languageCode,
        customerId: loginDetails != null ? loginDetails.customerId.toString() : "",
        customerBasketId: cartList[index].customerBasketId.toString(),
        productId: cartList[index].prouductId.toString(),
        action: action.toString(),
        deviceId: deviceToken
      );
      if (master != null) {
        if (master.success == 1) {
          CommonUtils.showGreenToastMessage(master.message.toString());
          totalPrice = master.totalprice.toString();
          if (action == 0) {
            cartList.removeAt(index);
            Provider.of<BottomNavBarViewModel>(mContext, listen: false).getCartList();
          } else {
            cartList[index].customerBasketQuantity += action;
          }
        } else {
          CommonUtils.showRedToastMessage(master.message.toString());
        }
      }
      CommonUtils.hideProgressDialog(mContext);
    notifyListeners();
  }

}
