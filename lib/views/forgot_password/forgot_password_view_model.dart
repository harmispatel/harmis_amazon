import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/language_master.dart';
import 'package:big_mart/models/message.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:flutter/cupertino.dart';

class ForgotPasswordViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  List<LanguageMaster> languageList = new List();
  String languageCode;
  String deviceId;

  void attachContext(BuildContext context) {
    mContext = context;
  }

  void forgotPasswordApi({String email}) async {
    languageCode = await appPreferences.getLanguageCode();
    MessageMaster master = await _services.forgotPassword(
        languageCode: languageCode,
        email: email,
        onStartLoading: () {
          CommonUtils.showProgressDialog(mContext);
        },
        onStopLoading: () {
          CommonUtils.hideProgressDialog(mContext);
        },
        onNoInternet: () {
          CommonUtils.showToastMessage(S.of(mContext).noInternet);
        });
    if (master != null) {
      if (master.success == 1) {
        CommonUtils.showGreenToastMessage(master.message.toString());
        Navigator.pop(mContext);
      } else {
        CommonUtils.showRedToastMessage(master.message.toString());
      }
    }
  }
}
