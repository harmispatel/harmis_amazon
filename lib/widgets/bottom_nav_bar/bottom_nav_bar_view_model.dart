import 'dart:async';

import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/models/cart_master.dart';
import 'package:big_mart/models/message.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBarViewModel extends ChangeNotifier {
  int currentIndex = 0;
  int selectedIndex = 0;
  String _deviceToken = "";
  String _languageCode = "";
  LoginDetails loginDetails;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  bool isLocationSent = true;
  int cartCount = 0;
  BuildContext mContext;
  List<bool> isSelected = [false, false, false, false, false];
  Timer _timer;

  void attachContext(BuildContext context) {
    this.mContext = context;
    selectedIndex= 0;
    getLoginDetails();
    setLanguageToBackend();
    getCartList();
  }


/*  void selectedTab(int index, BuildContext context) async {
    loginDetails = await appPreferences.getLoginDetails();
    currentIndex = index;
    notifyListeners();
    *//* if (index == 3 && loginDetails == null) {
     Navigator.push(context, MaterialPageRoute(builder: (_context) {
       return LoginView();
     }));
   } else {
      currentIndex = index;
      notifyListeners();
   }*//*
  }*/

  void selectedTab(int index, BuildContext context) async {
    loginDetails = await appPreferences.getLoginDetails();
    selectedIndex = index;
    notifyListeners();
    /* if (index == 3 && loginDetails == null) {
     Navigator.push(context, MaterialPageRoute(builder: (_context) {
       return LoginView();
     }));
   } else {
      currentIndex = index;
      notifyListeners();
   }*/
  }

  void selectedTabWeb(int index, BuildContext context) async {
    loginDetails = await appPreferences.getLoginDetails();
    currentIndex = index;
    isSelected[currentIndex] = true;
    notifyListeners();
    /* if (index == 3 && loginDetails == null) {
     Navigator.push(context, MaterialPageRoute(builder: (_context) {
       return LoginView();
     }));
   } else {
      currentIndex = index;
      notifyListeners();
   }*/
  }

/*  void changeTab(int index) {
    currentIndex = index;
    notifyListeners();
  }*/

  void changeTab(int index) {
    selectedIndex = index;
    notifyListeners();
  }


  void getCartList() async {
    cartCount = 0;
    loginDetails = await appPreferences.getLoginDetails();
    _languageCode = await appPreferences.getLanguageCode();
    _deviceToken = await appPreferences.getDeviceToken();
    CartMaster master = await _services.getCartList(
        languageCode: _languageCode,
        customerId:
            loginDetails != null ? loginDetails.customerId.toString() : "",
        deviceId: _deviceToken);
    if (master != null) {
      if (master.success == 1 && master.result != null) {
        cartCount = master.result.length;
      }
    }
    notifyListeners();
  }
  void getLoginDetails() async {
    loginDetails = await appPreferences.getLoginDetails();
    notifyListeners();
  }

  void setLanguageToBackend() async {
    String languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    print("your current lan=>"+languageCode.toString());
    }
}
