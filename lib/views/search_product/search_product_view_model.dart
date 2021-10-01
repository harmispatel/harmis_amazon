import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/cart_master.dart';
import 'package:big_mart/models/product_master.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchProductViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode;
  LoginDetails loginDetails;
  bool isApiLoading = true;
  List<ProductData> productList = new List();
  int totalCount = 0, page = 0;
  String message = "";
  String searchKeyword = "";
  final scaffoldkey = new GlobalKey<ScaffoldState>();

  void attachContext(BuildContext context) {
    mContext = context;
    page = 0;
    totalCount = 0;
    searchKeyword = "";
  }

  void getProductList() async {
    if (page == 0) {
      isApiLoading = true;
      productList.clear();
      notifyListeners();
    }
    print("search keyword: " + searchKeyword);
    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    ProductMaster master = await _services.searchProduct(
      languageCode: languageCode,
      customerId:
          loginDetails != null ? loginDetails.customerId.toString() : "",
      pagination: page.toString(),
      keyword: searchKeyword,
    );
    isApiLoading = false;
    if (master != null) {
      if (master.success == 1) {
        if (page == 0 && master.totalRecord != null) {
          totalCount = master.totalRecord;
        }
        if (master.productData != null && master.productData.length > 0) {
          productList.addAll(master.productData);
        }
      } else {
        message = master.message;
      }
    }
    notifyListeners();
  }
}
