import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/country_master.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/register/choose_country.dart';
import 'package:big_mart/views/verify_account/verify_account_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profile_view_model.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final globalKey = new GlobalKey();
  ProfileViewModel mViewModel;
  bool _passwordVisible = false;
  TextEditingController mFirstNameController = new TextEditingController();
  TextEditingController mLastNameController = new TextEditingController();
  TextEditingController mMobileController = new TextEditingController();
  TextEditingController mEmailController = new TextEditingController();
  TextEditingController mPasswordController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<ProfileViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.getLoginDetails(
        onSuccess: (LoginDetails loginDetails) {
          if (loginDetails != null) {
            mFirstNameController.text = loginDetails.firstName?? "";
            mLastNameController.text = loginDetails.lastName?? "";
            mMobileController.text = loginDetails.mobile?? "";
            mEmailController.text = loginDetails.email?? "";
            mViewModel.selectedDate = loginDetails.dob?? "";
            if (!CommonUtils.isEmpty(loginDetails.gender)) {
              if (loginDetails.gender == AppConstants.GENDER_TYPE_MR) {
                mViewModel.mTitle = 1;
              } else if (loginDetails.gender == AppConstants.GENDER_TYPE_MRS) {
                mViewModel.mTitle = 2;
              } else if (loginDetails.gender == AppConstants.GENDER_TYPE_MS) {
                mViewModel.mTitle = 3;
              }
            }
          }
          mViewModel.initCountryList();
        }
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<ProfileViewModel>(context);

    final tvProfileDesc = Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(bottom: 16),
      child: Text(
        S.of(context).editProfileLabel,
        style: CommonStyle.getAppFont(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: CommonColors.dark_6060),
      ),
    );

    final layoutTitle = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).title,
            style: CommonStyle.getAppFont(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: CommonColors.dark_6060),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  new Radio(
                    activeColor: Colors.orangeAccent,
                    value: 1,
                    groupValue: mViewModel.mTitle,
                    onChanged: mViewModel.handleTitleValueChange,
                  ),
                  new Text(
                    S.of(context).mr,
                    style: CommonStyle.getAppFont(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: CommonColors.dark_6060),
                  ),
                ],
              ),
              Row(
                children: [
                  new Radio(
                    value: 2,
                    activeColor: Colors.orangeAccent,
                    groupValue: mViewModel.mTitle,
                    onChanged: mViewModel.handleTitleValueChange,
                  ),
                  new Text(
                    S.of(context).mrs,
                    style: CommonStyle.getAppFont(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: CommonColors.dark_6060),
                  ),
                ],
              ),
              Row(
                children: [
                  new Radio(
                    value: 3,
                    activeColor: Colors.orangeAccent,
                    groupValue: mViewModel.mTitle,
                    onChanged: mViewModel.handleTitleValueChange,
                  ),
                  new Text(
                    S.of(context).ms,
                    style: CommonStyle.getAppFont(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: CommonColors.dark_6060),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );

    final layoutFirstName = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              S.of(context).firstname,
              style: CommonStyle.getAppFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: CommonColors.dark_6060),
            ),
          ),
          setTextField(S.of(context).firstname, mFirstNameController, true),
        ],
      ),
    );

    final layoutLastName = Container(
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              S.of(context).lastname,
              style: CommonStyle.getAppFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: CommonColors.dark_6060),
            ),
          ),
          setTextField(S.of(context).lastname, mLastNameController, true),
        ],
      ),
    );

    final countryDropDown = Container(
      height: 45,
      width: 60,
      margin: EdgeInsets.only(left: 8.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          value: mViewModel.selectedCountry,
          items: mViewModel.countryDropdownMenuItems,
          onChanged: mViewModel.onChangeCountryDropdownItem,
          icon: Container(),
          underline: Container(),
        ),
      ),
    );

   /* final layoutMobileNumber = Container(
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).mobileNumber,
            style: CommonStyle.getAppFont(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: CommonColors.color_515c6f),
          ),
          Container(
            height: 45,
            margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
            decoration: BoxDecoration(
                color: CommonColors.primaryLight,
                border: Border(
                    bottom: BorderSide(
                        color: CommonColors.primaryColor, width: 1))),
            child: Row(
              children: [
                //countryDropDown,
                Flexible(
                    child: setMobileTextField(
                        S.of(context).mobileNumber, mMobileController, true)),
              ],
            ),
          )
        ],
      ),
    );*/

    final layoutMobileNumber = Container(
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              S.of(context).mobileNumber,
              style: CommonStyle.getAppFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: CommonColors.dark_6060),
            ),
          ),
          Container(
            height: 45,
            margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
            decoration:BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ]),
            child: Row(
              children: [
                //countryDropDown,
                Flexible(
                    child: setMobileTextField(
                        S.of(context).mobileNumber, mMobileController, true)),
              ],
            ),
          )
        ],
      ),
    );

    final layoutEmailAddress = Container(
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              S.of(context).emailAddress,
              style: CommonStyle.getAppFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: CommonColors.dark_6060),
            ),
          ),
          setTextField(S.of(context).emailAddress, mEmailController, false),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              S.of(context).emailCannotBeChanged,
              style: CommonStyle.getAppFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.withOpacity(0.7)),
            ),
          )
        ],
      ),
    );

    final layoutDateOfBirth = Container(
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              S.of(context).dateOfBirth,
              style: CommonStyle.getAppFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: CommonColors.dark_6060),
            ),
          ),
          InkWell(
            onTap: () {
              mViewModel.showBirthDatePicker();
            },
            child: Container(
              height: 45,
              width: double.infinity,
              margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.only(left: 18,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      CommonUtils.isEmpty(mViewModel.selectedDate)
                          ? S.of(context).dateOfBirth
                          : mViewModel.selectedDate,
                      style: CommonStyle.getAppFont(
                          color: CommonColors.dark_6060,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: CommonColors.dark_6060,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );

    final layoutNationality = mViewModel.selectedNationality != null
        ? Container(
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              S.of(context).nationality,
              style: CommonStyle.getAppFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: CommonColors.dark_6060),
            ),
          ),
          InkWell(
            onTap: () {
              _openNationalityPickerDialog();
            },
            child: Container(
              height: 45,
              width: double.infinity,
              margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ]),
              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: Text(
                        mViewModel.selectedNationality.countryName.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: CommonStyle.getAppFont(
                            color: CommonColors.dark_6060,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16,left: 16),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: CommonColors.dark_6060,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ) : Container();

    final btnSave = InkWell(
      onTap: () {
        if (isValid()) {
          mViewModel.loginApi(
            firstName: mFirstNameController.text,
            lastName: mLastNameController.text,
            mobilePhone: mMobileController.text
          );
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: 50,
        decoration: BoxDecoration(
            color: Colors.orangeAccent.withOpacity(.9),
            borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ]),
        child: Center(
          child: Text(
            S.of(context).save.toUpperCase(),
            style: CommonStyle.getAppFont(
                color: CommonColors.white,
                fontSize: 18,
                letterSpacing: 1,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );

    return Scaffold(
      key: globalKey,
      backgroundColor: CommonColors.white,
      appBar: AppBar(
        backgroundColor: CommonColors.dark_6060,
        elevation: 0.0,
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.only(left: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  height: 15,
                  child: Image.asset(
                    LocalImages.ic_arrow_back,
                    color: CommonColors.white,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 68, right: 85),
                  child: Text(
                    S.of(context).myProfile,
                    style: CommonStyle.getAppFont(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: CommonColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tvProfileDesc,
            layoutTitle,
            layoutFirstName,
            layoutLastName,
            layoutMobileNumber,
            layoutEmailAddress,
            SizedBox(height: 8,),
            layoutDateOfBirth,
            layoutNationality,
            btnSave,
          ],
        ),
      ),
    );
  }

  /*Widget setTextField(String placeholder, controller, bool enable) {
    return Container(
      height: 45,
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
      decoration: BoxDecoration(
          color: CommonColors.primaryLight,
          border: Border(
              bottom: BorderSide(color: CommonColors.primaryColor, width: 1))),
      child: TextField(
        enabled: enable,
        controller: controller,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: CommonStyle.getAppFont(
              color: CommonColors.primaryColor,
              fontWeight: FontWeight.w400,
              fontSize: 16.0),
          contentPadding: EdgeInsets.only(left: 10, right: 10),
          border: InputBorder.none,
        ),
        style: CommonStyle.getAppFont(
            color: CommonColors.primaryColor,
            fontWeight: FontWeight.w400,
            fontSize: 16.0),
        maxLines: 1,
        autocorrect: false,
      ),
    );
  }*/

  Widget setTextField(String placeholder, controller, bool enable) {
    return Container(
      height: 45,
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ]),
      child: TextField(
        enabled: enable,
        controller: controller,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: CommonStyle.getAppFont(
              color: CommonColors.dark_6060,
              fontWeight: FontWeight.w300,
              fontSize: 14.0),
          contentPadding: EdgeInsets.only(left: 18, right: 10),
          border: InputBorder.none,
        ),
        style: CommonStyle.getAppFont(
            color: CommonColors.dark_6060,
            fontWeight: FontWeight.w300,
            fontSize: 14.0),
        maxLines: 1,
        autocorrect: false,
      ),
    );
  }

  /*Widget setMobileTextField(String placeholder, controller, bool enable) {
    return TextField(
      enabled: enable,
      controller: controller,
      decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: CommonStyle.getAppFont(
              color: CommonColors.primaryColor,
              fontWeight: FontWeight.w400,
              fontSize: 16.0),
          contentPadding: EdgeInsets.only(left: 10, right: 10),
          border: InputBorder.none,
          counterText: ""),
      style: CommonStyle.getAppFont(
          color: CommonColors.primaryColor,
          fontWeight: FontWeight.w400,
          fontSize: 16.0),
      maxLines: 1,
      maxLength: 10,
      autocorrect: false,
      keyboardType: TextInputType.number,
    );
  }
  */

  Widget setMobileTextField(String placeholder, controller, bool enable) {
    return TextField(
      enabled: enable,
      controller: controller,
      decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: CommonStyle.getAppFont(
              color: CommonColors.dark_6060,
              fontWeight: FontWeight.w300,
              fontSize: 14.0),
          contentPadding: EdgeInsets.only(left: 18, right: 10),
          border: InputBorder.none,
          counterText: ""),
      style: CommonStyle.getAppFont(
          color: CommonColors.dark_6060,
          fontWeight: FontWeight.w300,
          fontSize: 14.0),
      maxLines: 1,
      maxLength: 10,
      autocorrect: false,
      keyboardType: TextInputType.number,
    );
  }

  void _openNationalityPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => ChooseCountryDialog(
        title: S.of(context).nationality,
        countryList: mViewModel.countryList,
        onCountrySelected: (CountryDetails country) {
          Navigator.pop(context);
          mViewModel.selectedNationality = country;
          mViewModel.notifyListeners();
        },
      ),
    );
  }

  bool isValid() {
    if (mFirstNameController.text.isEmpty) {
      CommonUtils.showSnackBar(S.of(context).enterFirstName, globalKey);
      return false;
    } else if (mLastNameController.text.isEmpty) {
      CommonUtils.showSnackBar(S.of(context).enterLastName, globalKey);
      return false;
    } else if (mMobileController.text.isEmpty) {
      CommonUtils.showSnackBar(S.of(context).enterMobileNumber, globalKey);
      return false;
    } else if (mViewModel.selectedDate.isEmpty) {
      CommonUtils.showSnackBar(S.of(context).chooseDateOfBirth, globalKey);
      return false;
    } else {
      return true;
    }
  }
}
