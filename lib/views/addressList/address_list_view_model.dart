import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/models/address.dart';
import 'package:big_mart/models/cart_message_master.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:flutter/cupertino.dart';

class AddressListViewModel with ChangeNotifier {

  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode;
  List<AddressDetails> addressList = new List();
  bool isApiLoading = false;
  LoginDetails loginDetails;
  String message;
  AddressDetails selectedAddress;

  void attachContext(BuildContext context) {
    mContext = context;
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



}
