import 'dart:convert';

import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/language_master.dart';
import 'package:big_mart/models/signup_request.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar_web.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class VerifyAccountViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  List<LanguageMaster> languageList = new List();
  String languageCode;
  String otpCode = "";
  String deviceId = "";
  String deviceType = "";
  FirebaseAuth _auth = FirebaseAuth.instance;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  void attachContext(BuildContext context) {
    mContext = context;
    otpCode = "";
  }

  void verifyAccount({String id}) async {
    languageCode = await appPreferences.getLanguageCode();
    LoginMaster master = await _services.verifyAccount(
        languageCode: languageCode,
        id: id,
        code: otpCode,
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
        appPreferences.setLoginDetails(json.encode(master.result.toJson()));
        Navigator.pushAndRemoveUntil(mContext,
            MaterialPageRoute(builder: (context) {
          return kIsWeb ? bottomNavigationBarWeb() : bottomNavigationBar();
        }), (Route<dynamic> route) => false);
      } else {
        CommonUtils.showRedToastMessage(master.message.toString());
      }
    }
  }

  void registerApi({SignUpRequest signUpRequest}) async {
    languageCode = await appPreferences.getLanguageCode();
    deviceId = await appPreferences.getDeviceToken();
    LoginMaster master = await _services.registerUser(
        languageCode: languageCode,
        firstName: signUpRequest.firstName,
        lastName: signUpRequest.lastName,
        mobile: signUpRequest.mobileNumber,
        gender: signUpRequest.gender,
        email: signUpRequest.email,
        password: signUpRequest.password,
        dob: signUpRequest.dob,
        countryId: signUpRequest.countryId,
        deviceId: deviceId,
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
      if (master.success == 1 && master.result != null) {
        CommonUtils.showGreenToastMessage(master.message.toString());

        CommonUtils.showGreenToastMessage(master.message.toString());
        appPreferences.setLoginDetails(json.encode(master.result.toJson()));

        Navigator.of(mContext).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    kIsWeb ? bottomNavigationBarWeb() : bottomNavigationBar()),
            (Route<dynamic> route) => false);
      } else {
        CommonUtils.showRedToastMessage(master.message.toString());
      }
    }
  }

  void phoneSignIn(
      {String phoneNUmber,
      String smsOTP,
      BuildContext context,
      String vid,
      SignUpRequest signupRequest}) async {
    CommonUtils.showProgressDialog(context);
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: vid,
        smsCode: smsOTP,
      );

      print("verificationId: " + vid + "otp: " + smsOTP);

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      final User user = authResult.user;
      final User currentUser = await _auth.currentUser;
      assert(user.uid == currentUser.uid);
      CommonUtils.hideProgressDialog(context);
      // signupRequest.mobileNumber = phoneNUmber;
      registerApi(signUpRequest: signupRequest);
    } catch (exception) {
      print("Exception" + exception.toString());
      CommonUtils.hideProgressDialog(context);
      handleError(exception, context);
    }
  }

  handleError(error, BuildContext context) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        CommonUtils.showSnackBar(S.of(context).invalidCode, scaffoldKey,
            color: Colors.red);
        break;
      default:
        print("PHONE AUTH ERROR: " + error.message);
        CommonUtils.showSnackBar(S.of(context).invalidCode, scaffoldKey,
            color: Colors.red);

        break;
    }
  }
}
