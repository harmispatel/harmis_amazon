import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/models/address.dart';
import 'package:big_mart/models/cart_message_master.dart';
import 'package:big_mart/models/message.dart';
import 'package:big_mart/models/product_details.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar_view_model.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode;
  LoginDetails loginDetails;
  bool isApiLoading = false;
  String message;
  AddressDetails selectedAddress;
  List<AddressDetails> addressList = new List();
  List<String> city = [];
  Result data;
  String currentAddress;
  String currentAddressId;

  void attachContext(BuildContext context) {
    mContext = context;
  }

  void addAddressForCheckOut(value){
    city.add(value);
    notifyListeners();
  }

  void getAddressList() async {
    isApiLoading = true;
    selectedAddress = null;
    addressList.clear();
    /*addressList.add(new AddressDetails(isSelected: true));
    addressList.add(new AddressDetails());
    addressList.add(new AddressDetails());
    addressList.add(new AddressDetails());
    selectedAddress = addressList[0];*/
    notifyListeners();

    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    AddressDetailsMaster master = await _services.getAddressList(
      languageCode: languageCode,
      customerId:
      loginDetails != null ? loginDetails.customerId.toString() : "",
    );
    isApiLoading = false;
    if (master != null) {
      if (master.success == 1) {
        if (master.result != null && master.result.length > 0) {
          addressList.addAll(master.result);
        }
      } else {
        message = master.message;
      }
    }
    notifyListeners();
  }

  void removeAddress({String addressId, BuildContext context}) async {
    CommonUtils.showProgressDialog(mContext);
    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    if (loginDetails != null) {
      CartMessageMaster master = await _services.deleteAddress(
          languageCode: languageCode,
          addressId: addressId,
          customersId: loginDetails.customerId.toString()
      );
      if (master != null) {
        if (master.success == 1) {
          CommonUtils.showGreenToastMessage(master.message.toString());
          getAddressList();
        } else {
          CommonUtils.showRedToastMessage(master.message.toString());
        }
      }
    }
    CommonUtils.hideProgressDialog(mContext);
    notifyListeners();
  }

  void placeOrder({String addressId}) async {
    CommonUtils.showProgressDialog(mContext);
    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    if (loginDetails != null) {
      MessageMaster master = await _services.placeOrder(
          languageCode: languageCode,
          addressId: addressId,
          customersId: loginDetails.customerId.toString());
      CommonUtils.hideProgressDialog(mContext);
      if (master != null) {
        if (master.success == 1) {
          CommonUtils.showGreenToastMessage(master.message.toString());
          Provider.of<BottomNavBarViewModel>(mContext, listen: false).changeTab(0);
          Navigator.pushAndRemoveUntil(mContext,
              MaterialPageRoute(builder: (context) {
            return kIsWeb ? bottomNavigationBarWeb() : bottomNavigationBar();
          }), (Route<dynamic> route) => false);
        }
        else
          {
          CommonUtils.showRedToastMessage(master.message.toString());
        }
      }
    }
  }

  void buyAgain({String addressId, String orderId}) async {
    CommonUtils.showProgressDialog(mContext);
    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    if (loginDetails != null) {
      MessageMaster master = await _services.buyAgain(
          languageCode: languageCode,
          addressId: addressId,
          orderId: orderId,
          paymentMethod: "COD",
          customerId: loginDetails.customerId.toString());
      CommonUtils.hideProgressDialog(mContext);
      if (master != null) {
        if (master.success == 1) {
          CommonUtils.showGreenToastMessage(master.message.toString());
          Navigator.pushAndRemoveUntil(mContext,
              MaterialPageRoute(builder: (context) {
            return kIsWeb ? bottomNavigationBarWeb() : bottomNavigationBar();
          }), (Route<dynamic> route) => false);
        } else {
          CommonUtils.showRedToastMessage(master.message.toString());
        }
      }
    }
  }
}
