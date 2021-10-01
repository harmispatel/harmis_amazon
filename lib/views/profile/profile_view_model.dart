import 'dart:convert';

import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/country_master.dart';
import 'package:big_mart/models/language_master.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode;
  LoginDetails loginDetails;

  CountryDetails selectedCountry;
  List<CountryDetails> countryList = new List();
  List<DropdownMenuItem<CountryDetails>> countryDropdownMenuItems;

  CountryDetails selectedNationality;
  List<CountryDetails> nationalityList = new List();
  List<DropdownMenuItem<CountryDetails>> nationalityDropdownMenuItems;

  String selectedDate = "";
  int mTitle = 1;

  void attachContext(BuildContext context) {
    mContext = context;
    selectedDate = "";
  }

  void getLoginDetails({Function onSuccess}) async {
    loginDetails = await appPreferences.getLoginDetails();
    onSuccess(loginDetails);
  }

  void handleTitleValueChange(int value) {
    mTitle = value;
    notifyListeners();
  }

  void initCountryList() async {
    countryList.clear();
    nationalityList.clear();
    notifyListeners();

    CommonUtils.showProgressDialog(mContext);
    languageCode = await appPreferences.getLanguageCode();
    CountryMaster master = await _services.getCountryList(
        languageCode: languageCode,
        onStartLoading: () {

        },
        onStopLoading: () {

        },
        onNoInternet: () {
          CommonUtils.showToastMessage(S.of(mContext).noInternet);
        });
    if (master != null && master.result != null && master.result.length > 0) {
      countryList.addAll(master.result);
      //countryDropdownMenuItems = buildCountryDropdownMenuItems(countryList);
      //selectedCountry = countryDropdownMenuItems[0].value;

      nationalityList.addAll(master.result);
      //nationalityDropdownMenuItems = buildNationalityDropdownMenuItems(nationalityList);
      //selectedNationality = nationalityDropdownMenuItems[0].value;
      selectedNationality = nationalityList[0];
      for (int i = 0; i < nationalityList.length; i++) {
        if (nationalityList[i].countryId.toString() == loginDetails.countryId) {
          selectedNationality = nationalityList[i];
          break;
        }
      }
    }
    CommonUtils.hideProgressDialog(mContext);
    notifyListeners();
  }

  List<DropdownMenuItem<CountryDetails>> buildCountryDropdownMenuItems(List arrayList) {
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
                  height: 15, width: 15,
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

  onChangeCountryDropdownItem(CountryDetails country) {
    this.selectedCountry = country;
    notifyListeners();
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
            primaryColor: CommonColors.primaryColor,
            accentColor: CommonColors.primaryDarkColor,
            colorScheme: ColorScheme.light(primary: CommonColors.primaryColor),
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

  void loginApi({
    String firstName,
    String lastName,
    String mobilePhone,}) async {
    languageCode = await appPreferences.getLanguageCode();
    LoginMaster master = await _services.editProfile(
        languageCode: languageCode,
        customerId: loginDetails.customerId.toString(),
        firstName: firstName,
        lastName: lastName,
        dob: selectedDate,
        gender: mTitle.toString(),
        countryId: selectedNationality.countryId.toString(),
        mobilePhone: mobilePhone,
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
      } else {
        CommonUtils.showRedToastMessage(master.message.toString());
      }
    }
  }
}
