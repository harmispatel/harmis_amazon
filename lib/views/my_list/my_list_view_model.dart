import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/models/category.dart';
import 'package:big_mart/models/favourite_master.dart';
import 'package:big_mart/models/product_master.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:flutter/cupertino.dart';

class MyListViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode;
  List<ProductData> productList = new List();
  bool isApiLoading = false;
  LoginDetails loginDetails;
  String message;

  void attachContext(BuildContext context) {
    mContext = context;
  }

  void getProductList() async {
      isApiLoading = true;
      productList.clear();
      notifyListeners();

    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
      FavouriteMaster master = await _services.getFavouriteList(
      languageCode: languageCode,
      customerId: loginDetails != null ? loginDetails.customerId.toString() : "",
    );
    isApiLoading = false;
    if (master != null) {
      if (master.success == 1) {
        if (master.result != null && master.result.length > 0) {
          productList.addAll(master.result);
        }
      } else {
        message = master.message;
      }
    }
    notifyListeners();
  }
}