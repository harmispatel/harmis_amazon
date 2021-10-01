import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/category.dart';
import 'package:big_mart/models/message.dart';
import 'package:big_mart/models/social_login.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:big_mart/views/login/login_view.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar_view_model.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar_web.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class MoreViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode;
  LoginDetails loginDetails;
  int selectedLanguage;
  String deviceId;
  bool isSignIn = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  FacebookLogin facebookLogin = FacebookLogin();
  SocialLogin socialLog;

  void attachContext(BuildContext context) {
    mContext = context;
  }

  void getLoginDetails() async {
    loginDetails = await appPreferences.getLoginDetails();
    notifyListeners();
  }

  void setCurrentLanguage() async {
    languageCode = await appPreferences.getLanguageCode();
    if (languageCode == AppConstants.LANGUAGE_ENGLISH) {
      selectedLanguage = 0;
    } else {
      selectedLanguage = 1;
    }
    notifyListeners();
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
        print("change lang=>"+master.message.toString());
        return true;
      }else{
        return false;
      }
    }
    notifyListeners();
  }


  void clearSession() {
    showDialog(
      context: mContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(S.of(mContext).logout),
          content: new Text(S.of(context).logoutConfirmationMessage),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(S.of(context).no),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            new FlatButton(
              child: new Text(S.of(context).yes),
              onPressed: () {
                appPreferences.setLoginDetails(null);
                Navigator.pushAndRemoveUntil(mContext,
                    MaterialPageRoute(builder: (context) {
                  return kIsWeb
                      ? bottomNavigationBarWeb()
                      : bottomNavigationBar();
                }), (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }


  void sociallogin({
    String firstname,
    String lastname,
    String email,
    String deviceType,
    String issocial,
    String loginWith,
    String socialId,
    String image
  }) async {
    languageCode = await appPreferences.getLanguageCode();
    deviceId = await appPreferences.getDeviceToken();
    SocialLogin master = await _services.socialLogin(
        languageCode: languageCode,
        firstName: firstname,
        lastName: lastname,
        email: email,
        deviceType: deviceType,
        issocial: issocial,
        loginWith: loginWith,
        socialId: socialId,
        image: image,
        deviceId: deviceId,
        onStartLoading: () {
          CommonUtils.showProgressDialog(mContext);
        },
        onStopLoading: () {
          CommonUtils.hideProgressDialog(mContext);
        },
        onNoInternet: () {
          CommonUtils.showToastMessage(S
              .of(mContext)
              .noInternet);
        });

    if (master != null) {
      if (master.success == 1) {
        CommonUtils.showGreenToastMessage(master.message.toString());
        Navigator.pushAndRemoveUntil(mContext,
            MaterialPageRoute(builder: (context) {
              return bottomNavigationBar();
            }), (Route<dynamic> route) => false);
      } else {
        CommonUtils.showRedToastMessage(master.message.toString());
      }
    }
  }

  Future<void> signingoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          // 'https://www.googleapis.com/auth/contacts.readonly'
        ]
    );
    try {
      await googleSignIn.signIn().then((value) {
        debugPrint(
            "Email: " + value.email
                +
                "photo: " + value.photoUrl
                +
                "name: " + value.displayName);
        sociallogin(firstname: value.displayName,
            email: value.email,
            lastname: "XYZ",
            deviceType: "1",
            issocial: "1",
            loginWith: "google",
            socialId: value.id,
            image: "hfddoifjope");
        // googleSignIn.signOut();
      });
    }
    catch (err) {
      debugPrint("your error is:" + err.toString());
      return null;
    }
  }

  Future<void> handleLogin() async {
    print("facebook login");

    FacebookLoginResult result = await facebookLogin.logIn(['email']);
    print("facebook result=>" + result.status.toString());
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        CommonUtils.showProgressDialog(mContext);
        sociallogin(firstname: "user",
            email: "user@gmail.com",
            lastname: "XYZ",
            deviceType: "1",
            issocial: "1",
            loginWith: "facebook",
            socialId: result.accessToken.userId,
            image: "");
        break;
      case FacebookLoginStatus.cancelledByUser:
        debugPrint("User cancelled login");
        break;
      case FacebookLoginStatus.error:
        debugPrint("Error");
        break;
    }
  }

  Future loginWithfacebook(FacebookLoginResult result) async {
    final FacebookAccessToken accessToken = result.accessToken;
    AuthCredential credential = FacebookAuthProvider.credential(
        accessToken.token);
    var a = await _auth.signInWithCredential(credential);
    isSignIn = true;
    _user = a.user;

    notifyListeners();
  }

  Future<void> logoutgoogle() async {
    await FirebaseAuth.instance.signOut();
    print("google signout successfully");
  }

  void logoutFacebook() async {
    await facebookLogin.logOut();
    Navigator.pushAndRemoveUntil(mContext,
        MaterialPageRoute(builder: (context) {
          return LoginView();
        }), (Route<dynamic> route) => false);
    print("facebook signout successfully");
  }
}
