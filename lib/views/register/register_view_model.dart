import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/country_master.dart';
import 'package:big_mart/models/language_master.dart';
import 'package:big_mart/models/signup_request.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/verify_account/verify_account_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RegisterViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  List<LanguageMaster> languageList = new List();
  String languageCode;
  String deviceId;

  CountryDetails selectedCountry;
  List<CountryDetails> countryList = new List();
  List<DropdownMenuItem<CountryDetails>> countryDropdownMenuItems;

  CountryDetails selectedNationality;
  List<CountryDetails> nationalityList = new List();
  List<DropdownMenuItem<CountryDetails>> nationalityDropdownMenuItems;

  String selectedDate = "";
  int mTitle = 1;

  FirebaseAuth _auth = FirebaseAuth.instance;
  String phoneCode = "";
  bool isOtpSending = false, isOtpVerifying = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  void attachContext(BuildContext context) {
    mContext = context;
    selectedDate = "";
  }

  void handleTitleValueChange(int value) {
    mTitle = value;
    notifyListeners();
  }

  void initCountryList() async {
    countryList.clear();
    nationalityList.clear();
    notifyListeners();

    // CommonUtils.showProgressDialog(mContext);
    languageCode = await appPreferences.getLanguageCode();
    CountryMaster master = await _services.getCountryList(
        languageCode: languageCode,
        onStartLoading: () {},
        onStopLoading: () {},
        onNoInternet: () {
          CommonUtils.showToastMessage(S.of(mContext).noInternet);
        });
    if (master != null && master.result != null && master.result.length > 0) {
      countryList.addAll(master.result);
      countryDropdownMenuItems = buildCountryDropdownMenuItems(countryList);
      selectedCountry = countryDropdownMenuItems[0].value;

      nationalityList.addAll(master.result);
      //nationalityDropdownMenuItems = buildNationalityDropdownMenuItems(nationalityList);
      //selectedNationality = nationalityDropdownMenuItems[0].value;
      selectedNationality = nationalityList[0];
    }
    // CommonUtils.hideProgressDialog(mContext);
    notifyListeners();
  }

  List<DropdownMenuItem<CountryDetails>> buildCountryDropdownMenuItems(
      List arrayList) {
    List<DropdownMenuItem<CountryDetails>> items = List();
    for (CountryDetails object in arrayList) {
      items.add(
        DropdownMenuItem(
          value: object,
          child: Padding(
            padding: const EdgeInsets.only(left: 1),
            child: Row(
              children: [
                Container(
                  height: 15,
                  width: 15,
                  margin: EdgeInsets.only(right: 2),
                  child: Image.network(object.countryImg.toString()),
                ),
                Text(
                  "+" + object.countyCode.toString(),
                  style: CommonStyle.getAppFont(
                      color: CommonColors.primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<CountryDetails>> buildNationalityDropdownMenuItems(
      List arrayList) {
    List<DropdownMenuItem<CountryDetails>> items = List();
    for (CountryDetails object in arrayList) {
      items.add(
        DropdownMenuItem(
          value: object,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              object.countryName,
              style: CommonStyle.getAppFont(
                  color: CommonColors.primaryColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal),
            ),
          ),
        ),
      );
    }
    return items;
  }

  onChangeNationalityDropdownItem(CountryDetails nationality) {
    this.selectedNationality = nationality;
    print("PhoneCode" + nationality.countyCode.toString());
    notifyListeners();
  }

  Future<void> showBirthDatePicker() async {
    DateTime minDate = new DateTime(DateTime.now().year - 100);
    DateTime maxDate = DateTime.now();
    /*CommonUtils.showDatePicker(
        maximumDate: maxDate,
        minimumDate: minDate,
        context: mContext,
        onDateConfirmed: (DateTime dateTime) {
          var formatter = new DateFormat('MM/dd/yyyy');
          selectedDate = formatter.format(dateTime);
          notifyListeners();
        });*/

    final DateTime selectedDateTime = await showDatePicker(
      context: mContext,
      initialDate: maxDate,
      firstDate: minDate,
      lastDate: maxDate,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.orangeAccent.withOpacity(0.9),
            accentColor: Colors.orangeAccent.withOpacity(0.9),
            colorScheme: ColorScheme.light(primary: Colors.orangeAccent.withOpacity(0.9),),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );
    if (selectedDateTime != null) {
      var formatter = new DateFormat('MM/dd/yyyy');
      selectedDate = formatter.format(selectedDateTime);
      notifyListeners();
    }
  }

  void registerApi({
    String firstName,
    String lastName,
    String mobile,
    String email,
    String password,
  }) async {
    languageCode = await appPreferences.getLanguageCode();
    deviceId = await appPreferences.getDeviceToken();
    SignUpRequest signUpRequest = new SignUpRequest();
    signUpRequest.firstName = firstName;
    signUpRequest.lastName = lastName;
    signUpRequest.mobileNumber = mobile;
    signUpRequest.countryId = selectedCountry.countryId.toString();
    signUpRequest.dob = selectedDate;
    signUpRequest.password = password;
    signUpRequest.gender = mTitle.toString();
    signUpRequest.email = email;
  }

  /* phone number authentication message*/

  Future<void> verifyPhone(
      {SignUpRequest signUpRequest,
      String phoneNumber,
      Function onCodeSent,
      BuildContext context}) async {
    print("phoneNumber" + phoneNumber);
    CommonUtils.showProgressDialog(context);
    try {
      if (kIsWeb) {
        print("Web Phone Authentication.");
        ConfirmationResult confirmationResult = await _auth.signInWithPhoneNumber(
            "+" + selectedCountry.countyCode.toString() + phoneNumber,
        );
        CommonUtils.hideProgressDialog(context);
        signUpRequest.phoneCode = "+91" /* selectedCountry.countyCode.toString()*/;
        Navigator.push(context, MaterialPageRoute(builder: (_context) {
          return VerifyAccountView(
            signUpRequest: signUpRequest,
            mobileNumber: phoneNumber,
            verificationId: confirmationResult.verificationId,
          );
        }));
      } else {
        final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
          CommonUtils.hideProgressDialog(context);
          signUpRequest.phoneCode = "+91"/*"+" + selectedCountry.countyCode.toString()*/;
          Navigator.push(context, MaterialPageRoute(builder: (_context) {
            return VerifyAccountView(
              signUpRequest: signUpRequest,
              mobileNumber: phoneNumber,
              verificationId: verId,
            );
          }));
        };
        await _auth.verifyPhoneNumber(
            phoneNumber:"+91"
               /* "+" + selectedCountry.countyCode.toString()*/ + phoneNumber,
            // PHONE NUMBER TO SEND OTP
            codeAutoRetrievalTimeout: (String verId) {
              //Starts the phone number verification process for the given phone number.
              //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
              // this.verificationId = verId;
            },
            codeSent: smsOTPSent,
            // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
            timeout: const Duration(seconds: 20),
            verificationCompleted: (AuthCredential phoneAuthCredential) {
              CommonUtils.hideProgressDialog(context);

              print(phoneAuthCredential);
            },
            verificationFailed: (FirebaseAuthException exceptio) {
              CommonUtils.hideProgressDialog(context);
              print('${exceptio.message}');
              // final snackBar = SnackBar(content: Text(exceptio.message));
              CommonUtils.showToastMessage(
                  "verification failed\n${exceptio.message}");
              notifyListeners();
            });
      }
    } catch (e) {
      CommonUtils.hideProgressDialog(context);
      notifyListeners();
      handleError(e, context);
    }
  }

  handleError(error, BuildContext context) {
    print(error.toString());
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        CommonUtils.showSnackBar(S.of(context).invalidCode, scaffoldKey,
            color: Colors.red);

        break;
      default:
        CommonUtils.showSnackBar(
            "PHONE AUTH ERROR: " + error.message, scaffoldKey,
            color: Colors.red);

        print("PHONE AUTH ERROR: " + error.message);
        break;
    }
  }
}
