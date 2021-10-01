
import 'package:flutter/material.dart';
import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/constant.dart';


class AppModel with ChangeNotifier {
  Map<String, dynamic> appConfig;
  bool isLoading = true;
  String message;
  bool darkTheme = false;
  String locale = AppConstants.LANGUAGE_ENGLISH;
  static var scaffoldKey;
  LoginDetails loginDetails;
  String _languageCode = "";
  AppPreferences appPreferences = new AppPreferences();
  Services _service = Services();
  String CountNotice = "0";

  void changeLanguage() async {
    String locale = await appPreferences.getLanguageCode();
    if (CommonUtils.isEmpty(locale)) {
      appPreferences.setLanguageCode(this.locale);
      locale = this.locale;
    }
    this.locale = locale;
    print("app model languge=>"+this.locale);
    notifyListeners();
  }

  void updateTheme(bool theme) {
    darkTheme = theme;
    notifyListeners();
  }
}


class App {
  Map<String, dynamic> appConfig;
  App(this.appConfig);
}
