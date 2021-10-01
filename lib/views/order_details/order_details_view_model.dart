import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/models/cart_master.dart';
import 'package:big_mart/models/order_details_master.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/views/addressList/address_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetailsViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode;
  LoginDetails loginDetails;
  OrderDetailsResult orderDetails;
  double rating = 1.0;

  void attachContext(BuildContext context) {
    mContext = context;
    orderDetails = null;
    notifyListeners();
  }

  void getOrderDetails(String orderId) async {
    notifyListeners();
    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    OrderDetailsMaster master = await _services.orderDetails(
        languageCode: languageCode,
        customerId:
            loginDetails != null ? loginDetails.customerId.toString() : "",
        orderId: orderId);
    if (master != null) {
      if (master.success == 1) {
        if (master.result != null) {
          orderDetails = master.result;
        }
      }
    }
    notifyListeners();
  }

  void getOrderproducts(String orderId) async {
    CommonUtils.showProgressDialog(mContext);

    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    CartMaster master = await _services.getproductOrderList(
        languageCode: languageCode, orderId: orderId);
    CommonUtils.hideProgressDialog(mContext);

    if (master != null) {
      if (master.success == 1) {
        if (master.result.length > 0) {
          Navigator.push(mContext, MaterialPageRoute(builder: (context) {
            return AddressListView(
              cartList: master.result,
              totalPrice: master.totalprice.toString(),
              orderId: orderDetails.orderId.toString(),
            );
          }));
        }
      }
    } else {
      CommonUtils.showToastMessage("opps something went wrong");
    }
    notifyListeners();
  }
}
