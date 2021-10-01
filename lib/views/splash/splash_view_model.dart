import 'dart:async';
import 'dart:convert';

import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/models/app.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/api_para.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/views/language_selection/language_selection_view.dart';
import 'package:big_mart/views/login/login_view.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashViewModel with ChangeNotifier {
  String _deviceToken = "";
  String _languageCode = "";
  AppPreferences appPreferences = new AppPreferences();
  LoginDetails loginDetails;
  Services _service = Services();

  startTimer(BuildContext context) {
    return new Timer(Duration(milliseconds: 2000), () async {
      _languageCode = await appPreferences.getLanguageCode();
      _deviceToken = await appPreferences.getDeviceToken();
      loginDetails = await appPreferences.getLoginDetails();
      _languageCode = await appPreferences.getLanguageCode();
      if (CommonUtils.isEmpty(_languageCode)) {
        redirectToLanguageSelection(context);
      } else if (loginDetails != null && loginDetails.customerId != null) {
        userDetailsApiCall(context);
      } else {
        redirectToHome(context);
      }
    });
  }

  void redirectToLanguageSelection(BuildContext context) async {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (_, __, ___) => LanguageSelectionView(from: false,)));
  }

  void redirectToLogin(BuildContext context) async {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (_, __, ___) => LoginView()));
  }

  void redirectToHome(BuildContext context) {
    Provider.of<AppModel>(context, listen: false).changeLanguage();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      // return bottomNavigationBar();
      return kIsWeb ? bottomNavigationBarWeb() : bottomNavigationBar();
    }), (Route<dynamic> route) => false);
  }

  userDetailsApiCall(BuildContext context) async {
    try {
      LoginMaster master = await _service.userDetails(getUserDetailsParams());
      if (master != null) {
        if (master.success == 1) {
          appPreferences.setLoginDetails(json.encode(master.result.toJson()));
        }
      }
    } catch (e) {}
    redirectToHome(context);
  }

  String getUserDetailsParams() {
    var map = new Map<String, dynamic>();
    // map[ApiParams.userId] = loginDetails.id;
    map[ApiParams.languageCode] = _languageCode;
    map[ApiParams.customerId] = loginDetails.customerId.toString();
    print("Parameter: " + json.encode(map));

    return json.encode(map);
  }
}
