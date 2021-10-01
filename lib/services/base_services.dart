import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:big_mart/models/address.dart';
import 'package:big_mart/models/banner_master.dart';
import 'package:big_mart/models/brand_master.dart';
import 'package:big_mart/models/cart_master.dart';
import 'package:big_mart/models/cart_message_master.dart';
import 'package:big_mart/models/category.dart';
import 'package:big_mart/models/country_master.dart';
import 'package:big_mart/models/favourite_master.dart';
import 'package:big_mart/models/google_address.dart';
import 'package:big_mart/models/invoice_master.dart';
import 'package:big_mart/models/message.dart';
import 'package:big_mart/models/order_details_master.dart';
import 'package:big_mart/models/order_master.dart';
import 'package:big_mart/models/product_details.dart';
import 'package:big_mart/models/product_master.dart';
import 'package:big_mart/models/social_login.dart';
import 'package:big_mart/models/track_order_model.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import '../utils/constant.dart';
import '../utils/constant.dart';
import '../utils/constant.dart';
import 'api_para.dart';
import 'api_para.dart';
import 'api_url.dart';

class Services {
  Future<LoginMaster> userDetails(String params,
      {Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final http.Response response = await http.post(ApiUrl.USER_DETAILS,
            headers: {"Content-Type": "application/json"}, body: params);
        print("URL: " + response.request.url.toString());
        print(response.body);
        return LoginMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<LoginMaster> login(
      {languageCode,
      email,
      password,
      deviceId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.email] = email;
        map[ApiParams.password] = password;
        map[ApiParams.deviceId] = deviceId;
        map[ApiParams.deviceType] = kIsWeb
            ? AppConstants.DEVICE_ACCESS_WEB
            : Platform.isAndroid
                ? AppConstants.DEVICE_ACCESS_ANDROID
                : AppConstants.DEVICE_ACCESS_IOS;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        print("1");
        if (onStartLoading != null) onStartLoading();
        getLoginParams();
        print("2");
        final http.Response response =
            await http.post(ApiUrl.LOGIN, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return LoginMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error 3: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<CountryMaster> getCountryList(
      {languageCode,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;

        /* map[ApiParams.deviceToken] = deviceToken;
        map[ApiParams.deviceType] = Platform.isAndroid
            ? AppConstants.DEVICE_ACCESS_ANDROID
            : AppConstants.DEVICE_ACCESS_IOS;*/
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.COUNTRIES, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        print("Response code: " + response.statusCode.toString());
        if (onStopLoading != null) onStopLoading();
        return CountryMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<LoginMaster> registerUser(
      {languageCode,
      String firstName,
      String lastName,
      String mobile,
      String gender,
      String email,
      String password,
      String dob,
      String countryId,
      String deviceId,
      String deviceType,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.firstName] = firstName;
        map[ApiParams.lastName] = lastName;
        map[ApiParams.mobilePhone] = mobile;
        map[ApiParams.gender] = gender;
        map[ApiParams.email] = email;
        map[ApiParams.password] = password;
        map[ApiParams.dob] = dob;
        map[ApiParams.countryId] = countryId;
        map[ApiParams.deviceId] = deviceId;
        // map[ApiParams.deviceType] = "3";
        map[ApiParams.deviceType] = kIsWeb
            ? AppConstants.DEVICE_ACCESS_WEB
            : Platform.isAndroid
                ? AppConstants.DEVICE_ACCESS_ANDROID
                : AppConstants.DEVICE_ACCESS_IOS;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.REGISTER, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return LoginMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<LoginMaster> verifyAccount(
      {languageCode,
      String id,
      String code,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.id] = id;
        map[ApiParams.code] = code;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.VERIFY_ACCOUNT, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return LoginMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<MessageMaster> forgotPassword(
      {languageCode,
      String email,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.email] = email;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.FORGOT_PASSWORD, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return MessageMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<BannerMaster> bannerList(
      {languageCode,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.BANNER_LIST, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return BannerMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<ProductMaster> popularProducts(
      {languageCode,
      String customerId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customerId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.POPULAR_PRODUCTS, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return ProductMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<ProductMaster> topSellerProducts(
      {languageCode,
      String customerId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customerId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.TOP_SALLER_PRODUCTS, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return ProductMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<ProductMaster> productList(
      {languageCode,
      String customerId,
      String pagination,
      String categories,
      String brands,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customerId;
        map[ApiParams.categories] = categories;
        map[ApiParams.brands] = brands;
        map[ApiParams.pagination] = pagination;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.PRODUCT_LIST, body: getLoginParams(),headers: {"Content-Type": "application/json"}
            );
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return ProductMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<CategoryMaster> categoryList(
      {languageCode,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.CATEGORY_LIST, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return CategoryMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    }
    else
      {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<CategoryMaster> subCategoryList(
      {languageCode,
      String categoryId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.categoriesId] = categoryId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.SUB_CATEGORY_LIST, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return CategoryMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<BrandMaster> brandList(
      {languageCode,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.BRAND_LIST, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return BrandMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<ProductMaster> offerList(
      {languageCode,
      String customerId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customerId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.OFFER_LIST, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return ProductMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<MessageMaster> addRemoveFromWishlist(
      {languageCode,
      String userId,
      String productId,
      String isType,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = userId;
        map[ApiParams.productId] = productId;
        map[ApiParams.isType] = isType;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response = await http
            .post(ApiUrl.ADD_REMOVE_WHISHLIST, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return MessageMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<FavouriteMaster> getFavouriteList(
      {languageCode,
      String customerId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customerId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.GET_FAVOURITE_LIST, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return FavouriteMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<ProductDetailsMaster> getProductDetails(
      {languageCode,
      String customerId,
      String productId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customerId;
        map[ApiParams.productId] = productId;
        // map[ApiParams.productId] = "4";
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.PRODUCT_DETAILS, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        debugPrint("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return ProductDetailsMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<CartMaster> getCartList(
      {languageCode,
      String customerId,
      String deviceId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customerId;
        map[ApiParams.deviceId] = deviceId;
        map[ApiParams.deviceType] = kIsWeb
            ? AppConstants.DEVICE_ACCESS_WEB
            : Platform.isAndroid
                ? AppConstants.DEVICE_ACCESS_ANDROID
                : AppConstants.DEVICE_ACCESS_IOS;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.CART_LIST, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return CartMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<MessageMaster> addToCart(
      {languageCode,
      String customerId,
      String productId,
      String qty,
      String deviceId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customerId;
        map[ApiParams.productId] = productId;
        map[ApiParams.deviceId] = deviceId;
        if (qty != null) {
          map[ApiParams.qty] = qty;
        }
        map[ApiParams.deviceType] = kIsWeb
            ? AppConstants.DEVICE_ACCESS_WEB
            : Platform.isAndroid
                ? AppConstants.DEVICE_ACCESS_ANDROID
                : AppConstants.DEVICE_ACCESS_IOS;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.ADD_TO_CART, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return MessageMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<CartMessageMaster> addRemoveFromCart(
      {languageCode,
      String customerId,
      String productId,
      String customerBasketId,
      String action,
      String deviceId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customerId;
        map[ApiParams.productId] = productId;
        map[ApiParams.customerBasketId] = customerBasketId;
        map[ApiParams.incrementDecremnet] = action;
        map[ApiParams.deviceId] = deviceId;
        map[ApiParams.deviceType] = kIsWeb
            ? AppConstants.DEVICE_ACCESS_WEB
            : Platform.isAndroid
                ? AppConstants.DEVICE_ACCESS_ANDROID
                : AppConstants.DEVICE_ACCESS_IOS;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.ADD_REMOVE_QUANTITY, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return CartMessageMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<ProductMaster> dealsList(
      {languageCode,
      String customerId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customerId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.DEALS_LIST, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return ProductMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<ProductMaster> searchProduct(
      {languageCode,
      String customerId,
      String keyword,
      String pagination,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.filter] = keyword;
        map[ApiParams.customerId] = customerId;
        map[ApiParams.pagination] = pagination;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.SEARCH_PRODUCT, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return ProductMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<MessageMaster> addReview(
      {languageCode,
      String customerId,
      String customerName,
      String productId,
      String rating,
      String review,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        final map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customerId;
        map[ApiParams.customerName] = customerName;
        map[ApiParams.productId] = productId;
        map[ApiParams.reviewsRating] = rating;
        map[ApiParams.reviewsText] = review;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.ADD_REVIEW, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return MessageMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<LoginMaster> editProfile(
      {languageCode,
      String customerId,
      String firstName,
      String lastName,
      String mobilePhone,
      String dob,
      String gender,
      String countryId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customerId;
        map[ApiParams.firstName] = firstName;
        map[ApiParams.lastName] = lastName;
        map[ApiParams.mobilePhone] = mobilePhone;
        map[ApiParams.dob] = dob;
        map[ApiParams.gender] = gender;
        map[ApiParams.countryId] = countryId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.EDIT_PROFILE, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return LoginMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<LoginMaster> registerCustomer(
      {map,
      String avatar,
      Function success,
      Function fail,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final request = await http.MultipartRequest(
          AppConstants.METHOD_POST, Uri.parse(ApiUrl.REGISTER));

      try {
        if (avatar != null || !avatar.startsWith("http")) {
          File imageFile = new File(avatar);
          var stream =
              new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
          var length = await imageFile.length();
          var multipartFile = new http.MultipartFile("image", stream, length,
              filename: basename(imageFile.path));
          request.files.add(multipartFile);
          print("profileImage: " + avatar.toString());
        }
      } catch (e) {}

      try {
        request.fields.addAll(map);
        request.send().then((response) {
          print("URL: " + response.request.url.toString());
          response.stream.transform(utf8.decoder).listen((value) {
            // print("Response: " + value);
            // print("statusCode: " + response.statusCode.toString());
            if (response.statusCode == 200) {
              LoginMaster master = LoginMaster.fromJson(json.decode(value));
              success(master);
            } else {
              fail();
            }
          });
        });
      } catch (e) {
        print("Error: " + e.toString());
        fail();
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<AddressDetailsMaster> getAddressList(
      {languageCode,
      String customerId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customerId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.ADDRESS_LIST, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return AddressDetailsMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<MessageMaster> addAddress(
      /*"customersId":"1",
  "postCode":"234",
  "firstName":"demo1",
  "city":"dddd",
  "address":"ssss",
  "mobile":"4334343434",
  "area":"ddfd",
  "landmark":"dfdsf",
  "language":"en"*/

      {String languageCode,
      String customersId,
      String firstName,
      String city,
      String address,
      String latitude,
      String longitude,
      String mobile,
      String blockNumber,
      String language,
      String addressId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        if (addressId != null) map[ApiParams.addressId] = addressId;
        map[ApiParams.customerId] = customersId;
        map[ApiParams.firstName] = firstName;
        map[ApiParams.city] = city;
        map[ApiParams.address] = address;
        map[ApiParams.lat] = latitude;
        map[ApiParams.lng] = longitude;
        map[ApiParams.mobile] = mobile;
        map[ApiParams.blokNumber] = blockNumber;
        map[ApiParams.deviceType] = kIsWeb
            ? AppConstants.DEVICE_ACCESS_WEB
            : Platform.isAndroid
                ? AppConstants.DEVICE_ACCESS_ANDROID
                : AppConstants.DEVICE_ACCESS_IOS;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.ADD_ADDRESS, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return MessageMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<CartMessageMaster> deleteAddress(
      /*"addressId":"3",
  "customersId":"16",
  "language":"en"*/

      {languageCode,
      String customersId,
      String addressId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customersId;
        map[ApiParams.addressId] = addressId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.DELETE_ADDRESS, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return CartMessageMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<MessageMaster> placeOrder(
      {languageCode,
      String customersId,
      String addressId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customersId;
        map[ApiParams.addressId] = addressId;
        map[ApiParams.paymentMethod] = "Cash on Delivery";
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.PLACE_ORDER, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return MessageMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<OrderMaster> orderList(
      {languageCode,
      String customerId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customerId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.ORDER_LIST, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return OrderMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<OrderDetailsMaster> orderDetails(
      {languageCode,
      String customerId,
      String orderId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customerId;
        map[ApiParams.orderId] = orderId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.ORDER_DETAILS, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return OrderDetailsMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<InvoiceDetailsMaster> invoiceDetails(
      {languageCode,
      String customerId,
      String orderId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customerId;
        map[ApiParams.orderId] = orderId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.INVOICE_DETAIS, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return InvoiceDetailsMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<MessageMaster> buyAgain(
      {languageCode,
      String customerId,
      String orderId,
      String addressId,
      String paymentMethod,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customerId;
        map[ApiParams.orderId] = orderId;
        map[ApiParams.addressId] = addressId;
        map[ApiParams.paymentMethod] = paymentMethod;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.BUY_AGAIN, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return MessageMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<CartMaster> getproductOrderList(
      {languageCode,
      String orderId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.orderId] = orderId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.GET_ORDER_PRODUCT, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return CartMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<TrackOrderMaster> getOrderTrackList(
      {languageCode,
      String orderId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.orderId] = orderId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.GET_TRACK_ORDER, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return TrackOrderMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<ProductMaster> similarProducts(
      {languageCode,
      String customerId,
      String productId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.customerId] = customerId;
        map[ApiParams.productId] = productId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.SIMILAR_PRODUCTS, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return ProductMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  Future<GoogleAddressMaster> getAddressFromLatlong(
      {double lat,
      double long,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        if (onStartLoading != null) onStartLoading();
        final response = await http.get(
            "https://maps.googleapis.com/maps/api/geocode/json?latlng=" +
                lat.toString() +
                "," +
                long.toString() +
                "+&key=" +
                AppConstants.googleApiKey);

        print("URL: " + response.request.url.toString());
        if (onStopLoading != null) onStopLoading();
        return GoogleAddressMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<MessageMaster> sendInvoice(
      {languageCode,
      String orderId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.orderId] = orderId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response =
            await http.post(ApiUrl.SEND_INVOICE, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return MessageMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  @override
  Future<MessageMaster> setLanguageToBackend(
      {languageCode,
      String userId,
      Function onStartLoading,
      Function onStopLoading,
      Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.userId] = userId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response = await http.post(
            ApiUrl.SET_LANGUAGE_TO_BACKEND_NOTIFICATION,
            body: getLoginParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return MessageMaster.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  Future<SocialLogin> socialLogin(
      {languageCode,
        String firstName,
        String lastName,
        String email,
        String deviceId,
        String deviceType,
        String issocial,
        String loginWith,
        String socialId,
        String image,
        Function onStartLoading,
        Function onStopLoading,
        Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getSocialParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.firstName] = firstName;
        map[ApiParams.lastName] = lastName;
        map[ApiParams.email] = email;
        map[ApiParams.deviceId] = deviceId;
        map[ApiParams.deviceType] = deviceType;
        map[ApiParams.issocial] = issocial;
        map[ApiParams.loginWith] = loginWith;
        map[ApiParams.socialId] = socialId;
        map[ApiParams.image] = image;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        if (onStartLoading != null) onStartLoading();
        final http.Response response = await http.post(
            ApiUrl.SOCIAL_LOGIN,
            body: getSocialParams());
        print("URL: " + response.request.url.toString());
        print("Response: " + response.body);
        if (onStopLoading != null) onStopLoading();
        return SocialLogin.fromJson(json.decode(response.body));
      } catch (err) {
        print("Error: " + err.toString());
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }
}

