import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/app.dart';
import 'package:big_mart/models/language_master.dart';
import 'package:big_mart/models/message.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:big_mart/views/login/login_view.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelectionViewModel with ChangeNotifier {
  BuildContext mContext;
  AppPreferences appPreferences = new AppPreferences();
  LoginDetails loginDetails;
  List<LanguageMaster> languageList = new List();
  String selectedLanguageCode;
  Services _services =  Services();

  void attachContext(BuildContext context) {
    mContext = context;
  }

  void addLanguages() async {
    languageList.clear();
    languageList.add(
        new LanguageMaster(
        language: S.of(mContext).english,
        languageCode: AppConstants.LANGUAGE_ENGLISH));
    languageList.add(
        new LanguageMaster(
        language: S.of(mContext).arabic,
        languageCode: AppConstants.LANGUAGE_ARABIC));

    selectedLanguageCode = await appPreferences.getLanguageCode();
    if (!CommonUtils.isEmpty(selectedLanguageCode)) {
      for (int i = 0; i < languageList.length; i++) {
        if (languageList[i].languageCode == selectedLanguageCode) {
          languageList[i].isSelected = true;
          break;
        }
      }
    }
    notifyListeners();
  }

  void changeLanguageCode() async {
    if (CommonUtils.isEmpty(selectedLanguageCode)) {
      CommonUtils.showToastMessage(
          S.of(mContext).pleaseChoosePreferredLanguage);
    } else {
      print("now your language code is=> " + selectedLanguageCode);
      await appPreferences.setLanguageCode(selectedLanguageCode);
      Provider.of<AppModel>(mContext, listen: false).changeLanguage();


      loginDetails = await appPreferences.getLoginDetails();
      await setLanguageToBackend();

        Navigator.pushAndRemoveUntil(mContext,
            MaterialPageRoute(builder: (context) {
              return kIsWeb ? bottomNavigationBarWeb() : bottomNavigationBar();
            }), (Route<dynamic> route) => false);

    }
  }

  Future<bool> setLanguageToBackend() async {
    String languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    if (loginDetails != null) {
      MessageMaster master = await _services.setLanguageToBackend(
        languageCode: languageCode,
        userId: loginDetails.customerId.toString(),
      );
      if (master != null) {
        return true;
      }
      else{
        return false;
      }
    }else{
      return false;
    }
  }
}
