import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/banner_master.dart';
import 'package:big_mart/models/cart_master.dart';
import 'package:big_mart/models/category.dart';
import 'package:big_mart/models/product_master.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode;
  LoginDetails loginDetails;
  bool isBannerLoading = true;
  bool isApiLoading = true;
  String message = "";
  List<BannerDetails> bannerList = new List();

  bool isCategoriesLoading = true;
  List<CategoryDetails> categoryList = new List();

  bool isOfferProductsLoading = true;
  List<ProductData> offerProductList = new List();

  bool isDealsProductsLoading = true;
  List<ProductData> dealsProductList = new List();

  bool isPopularProductsLoading = true;
  List<ProductData> popularProductList = new List();

  bool isTopSellerLoading = true;
  List<ProductData> topSellerList = new List();
  var scaffoldkey = new GlobalKey<ScaffoldState>();

  void setGlobalKey(GlobalKey homeViewKey){
    scaffoldkey = homeViewKey;
  }

  void clearList() {
    bannerList.clear();
    categoryList.clear();
    offerProductList.clear();
    dealsProductList.clear();
    popularProductList.clear();
    topSellerList.clear();
  }

  Future<void> attachContext(BuildContext context) async {
    mContext = context;
  }

  void getLoginDetails() async {
    loginDetails = await appPreferences.getLoginDetails();
    print("Login details"+loginDetails.toString());
    notifyListeners();
  }

  void getBannerList() async {
    if (bannerList.length == 0) {
      isBannerLoading = true;
      bannerList.clear();
      notifyListeners();
      languageCode = await appPreferences.getLanguageCode();
      loginDetails = await appPreferences.getLoginDetails();
      BannerMaster master =
          await _services.bannerList(languageCode: languageCode);
      isBannerLoading = false;
      if (master != null) {
        if (master.result != null && master.result.length > 0) {
          bannerList.addAll(master.result);
        }
      }
      notifyListeners();
    }
  }

  void getPopularProductList() async {
    // if (popularProductList.length == 0) {
      isPopularProductsLoading = true;
      popularProductList.clear();
      notifyListeners();

      languageCode = await appPreferences.getLanguageCode();
      loginDetails = await appPreferences.getLoginDetails();
      ProductMaster master = await _services.popularProducts(
          languageCode: languageCode,
          customerId:
              loginDetails != null ? loginDetails.customerId.toString() : "");
      isPopularProductsLoading = false;
      if (master != null) {
        if (master.productData != null && master.productData.length > 0) {
          popularProductList.addAll(master.productData);
        }
      }
      notifyListeners();
    //}
  }

  void initCategoryList() async {
   /* if (categoryList.length == 0) {*/
      categoryList.clear();
      isCategoriesLoading = true;
      isApiLoading = true;
      notifyListeners();

      languageCode = await appPreferences.getLanguageCode();
      CategoryMaster master = await _services.categoryList(
          languageCode: languageCode);
      isCategoriesLoading = false;
      isApiLoading = false;
      if (master != null) {
        if (master.success == 1) {
          if (master.result != null && master.result.length > 0) {
            categoryList.addAll(master.result);
          }
        }
      }
      notifyListeners();
    //}
  }

  void getOfferProductList() async {
    if (offerProductList.length == 0) {
      isOfferProductsLoading = true;
      offerProductList.clear();
      notifyListeners();

      languageCode = await appPreferences.getLanguageCode();
      loginDetails = await appPreferences.getLoginDetails();
      ProductMaster master = await _services.offerList(
          languageCode: languageCode,
          customerId:
              loginDetails != null ? loginDetails.customerId.toString() : "");
      isOfferProductsLoading = false;
      if (master != null) {
        if (master.productData != null && master.productData.length > 0) {
          offerProductList.addAll(master.productData);
        }
      }
      notifyListeners();
    }
  }

  void getDealsProductList() async {
    if (dealsProductList.length == 0) {
      isDealsProductsLoading = true;
      dealsProductList.clear();
      notifyListeners();

      languageCode = await appPreferences.getLanguageCode();
      loginDetails = await appPreferences.getLoginDetails();
      ProductMaster master = await _services.dealsList(
          languageCode: languageCode,
          customerId:
              loginDetails != null ? loginDetails.customerId.toString() : "");
      isDealsProductsLoading = false;
      if (master != null) {
        if (master.productData != null && master.productData.length > 0) {
          dealsProductList.addAll(master.productData);
        }
      }
      notifyListeners();
    }
  }

  void getTopSellerList() async {
   /* if (topSellerList.length == 0) {*/
      isTopSellerLoading = true;
      topSellerList.clear();
      notifyListeners();
      languageCode = await appPreferences.getLanguageCode();
      print("top seller =>"+languageCode.toString());
      loginDetails = await appPreferences.getLoginDetails();
      ProductMaster master = await _services.topSellerProducts(
          languageCode: languageCode,
          customerId:
              loginDetails != null ? loginDetails.customerId.toString() : "");
      isTopSellerLoading = false;
      if (master != null) {
        if (master.productData != null && master.productData.length > 0) {
          topSellerList.addAll(master.productData);
        }
      }
      notifyListeners();
    }
 // }
}
