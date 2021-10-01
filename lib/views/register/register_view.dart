import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/country_master.dart';
import 'package:big_mart/models/signup_request.dart';
import 'package:big_mart/services/api_url.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/web_view/web_view_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'choose_country.dart';
import 'register_view_model.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewModel mViewModel;
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
      mViewModel = Provider.of<RegisterViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.initCountryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<RegisterViewModel>(context);

    final tvCreateAccount = Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 16),
      child: Text(
        S.of(context).createNewAccount,
        style: CommonStyle.getAppFont(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            /*color: CommonColors.primaryColor*/
            color: CommonColors.dark_6060),
      ),
    );

    final layoutTitle = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              S.of(context).title,
              style: CommonStyle.getAppFont(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  /*color: CommonColors.color_515c6f*/
                  color: CommonColors.dark_6060),
            ),
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
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
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
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
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
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: CommonColors.dark_6060),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );

    /*final countryDropDown = Container(
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
    );*/

    final countryDropDown = mViewModel.selectedCountry != null
        ? InkWell(
            onTap: () {
              _openCountryCodePickerDialog();
            },
            child: Container(
              height: 45,
              width: 60,
              margin: EdgeInsets.only(left: 8.0,right: 20),
              child: Row(
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    margin: EdgeInsets.only(left: 12),
                    child: Image.network(
                        mViewModel.selectedCountry.countryImg.toString(),),
                  ),
                  Text(/*mViewModel.selectedCountry.countyCode.toString(),*/
                    "+91",
                    style: CommonStyle.getAppFont(
                        color: CommonColors.dark_6060,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal),
                  ),
                ],
              ),
            ),
          )
        : Container();

    final layoutMobileNumber = Container(
      height: 45,
      margin: EdgeInsets.only(top: 10.0, bottom: 8.0),
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
      child: Row(
        children: [
          countryDropDown,
          Flexible(
              child: setMobileTextField(
                  S.of(context).mobileNumber, mMobileController, true)),
        ],
      ),
    );

    final tvMobileHint = Container(
      padding: EdgeInsets.only(left: 20),
      child: Text(
        S.of(context).mobileHint,
        style: CommonStyle.getAppFont(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.grey.withOpacity(0.7)),
      ),
    );

    final tvPasswordValidation = Container(
      padding: EdgeInsets.only(left: 20),
      child: Text(
        S.of(context).passwordValidationText,
        style: CommonStyle.getAppFont(
            fontSize: 14,
            color: Colors.grey.withOpacity(0.7)),
      ),
    );

    final layoutBirthDate = InkWell(
      onTap: () {
        mViewModel.showBirthDatePicker();
      },
      child: Container(
        height: 45,
        width: double.infinity,
        margin: EdgeInsets.only(top: 10.0, bottom: 8.0),
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
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20,bottom: 5),
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
                color: CommonColors.dark_6060.withOpacity(.4
                ),
              ),
            ],
          ),
        ),
      ),
    );

    /*final nationalityDropDown = Container(
      height: 45,
      width: double.infinity,
      margin: EdgeInsets.only(
          top: 8.0,
          bottom: 8.0
      ),
      decoration: BoxDecoration(
          color: CommonColors.primaryLight,
          border: Border(bottom: BorderSide(color: CommonColors.primaryColor, width: 1))
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          value: mViewModel.selectedNationality,
          items: mViewModel.nationalityDropdownMenuItems,
          onChanged: mViewModel.onChangeNationalityDropdownItem,
          icon: Icon(Icons.keyboard_arrow_down, color: CommonColors.primaryColor,),
          underline: Container(),
        ),
      ),
    );*/

    final nationalityDropDown = mViewModel.selectedNationality != null
        ? InkWell(
            onTap: () {
              _openNationalityPickerDialog();
            },
            child: Container(
              height: 45,
              width: double.infinity,
              margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
              decoration: BoxDecoration(
                  color: CommonColors.primaryLight,
                  border: Border(
                      bottom: BorderSide(
                          color: CommonColors.primaryColor, width: 1))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(mViewModel.selectedNationality.countryName.toString(),
                      //mViewModel.selectedNationality.countryName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: CommonStyle.getAppFont(
                          color: CommonColors.primaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: CommonColors.primaryColor,
                  ),
                ],
              ),
            ),
          )
        : Container();

    final btnRegister = InkWell(
      onTap: () {
        //FocusScope.of(context).requestFocus(FocusNode());
        if (isValid()) {
          String mobile = mMobileController.text.replaceAll(new RegExp(r'^0+(?=.)'), '');
          SignUpRequest signUpRequest = new SignUpRequest();
          signUpRequest.firstName = mFirstNameController.text;
          signUpRequest.lastName = mLastNameController.text;
          signUpRequest.mobileNumber = mobile;
          signUpRequest.countryId = "+91";
             /* mViewModel.selectedCountry.countryId.toString();*/
          signUpRequest.dob = mViewModel.selectedDate;
          signUpRequest.password = mPasswordController.text;
          signUpRequest.gender = mViewModel.mTitle.toString();
          signUpRequest.email = mEmailController.text;

          mViewModel.verifyPhone(
              signUpRequest: signUpRequest,
              phoneNumber: mobile,
              onCodeSent: () {},
              context: context);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 30),
        height: 50,
        decoration: BoxDecoration(
            color: Colors.orangeAccent.withOpacity(0.9),
            borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ]),
        child: Center(
          child: Text(
            S.of(context).register,
            style: CommonStyle.getAppFont(
                color: CommonColors.white,
                fontSize: 18,
                letterSpacing: 1,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );

   /* final layoutTermsAndCondition = InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_context) {
              return WebViewPage(
                title: S.of(context).termsAndCondition,
                url: ApiUrl.TERMS_AND_CONDITION,
              );
            }));
      },
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).byProceeding + " ",
              style: CommonStyle.getAppFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: CommonColors.color_515c6f),
            ),
            Flexible(
              child: Text(
                S.of(context).termsAndCondition,
                style: CommonStyle.getAppFont(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: CommonColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );*/

    final layoutTermsAndCondition = InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_context) {
              return WebViewPage(
                title: S.of(context).termsAndCondition,
                url: ApiUrl.TERMS_AND_CONDITION,
              );
            }));
      },
      child: Container(
        margin: EdgeInsets.only(top: 25, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Proceed by accepting"+ " ",
              style: CommonStyle.getAppFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: CommonColors.color_515c6f),
            ),
            Flexible(
              child: Text(
                S.of(context).termsAndCondition,
                style: CommonStyle.getAppFont(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: CommonColors.dark_6060),
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      key: mViewModel.scaffoldKey,
      resizeToAvoidBottomInset : false,
      backgroundColor: CommonColors.white,
      appBar: AppBar(
        backgroundColor: CommonColors.white,
        elevation: 0.0,
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.only(left: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  height: 15,
                  child: Image.asset(LocalImages.ic_arrow_back,color: Colors.black,),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 28,
                    child: Image.asset(LocalImages.ic_amazon_logo),
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
            tvCreateAccount,
            layoutTitle,
            SizedBox(height: 4,),
            setTextField(S.of(context).firstname, mFirstNameController, true),
            SizedBox(height: 8,),
            setTextField(S.of(context).lastname, mLastNameController, true),
            SizedBox(height: 8,),
            layoutMobileNumber,
            tvMobileHint,
            SizedBox(height: 10,),
            setTextField(S.of(context).emailAddress, mEmailController, true),
            SizedBox(height: 8,),
            setPasswordTextField(
                S.of(context).password, mPasswordController, true),
            tvPasswordValidation,
            SizedBox(height: 10,),
            layoutBirthDate,
            //nationalityDropDown,
            btnRegister,
            layoutTermsAndCondition,
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
        cursorColor: CommonColors.dark_6060,
        enabled: enable,
        textInputAction: TextInputAction.next,
        controller: controller,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: CommonStyle.getAppFont(
              color: CommonColors.dark_6060,
              fontWeight: FontWeight.w300,
              fontSize: 14.0),
          contentPadding: EdgeInsets.only(left: 20, right: 20,bottom: 5),
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
  }*/

  Widget setMobileTextField(String placeholder, controller, bool enable) {
    return TextField(
      textInputAction: TextInputAction.next,
      enabled: enable,
      cursorColor: CommonColors.dark_6060,
      controller: controller,
      decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: CommonStyle.getAppFont(
              color: CommonColors.dark_6060,
              fontWeight: FontWeight.w300,
              fontSize: 14.0),
          contentPadding: EdgeInsets.only(left: 2, right: 10,bottom: 5),
          border: InputBorder.none,
          counterText: ""),
      style: CommonStyle.getAppFont(
          color: CommonColors.dark_6060,
          fontWeight: FontWeight.w300,
          fontSize: 14.0),
      maxLines: 1,
      maxLength: 10,
      autocorrect: false,
      keyboardType: TextInputType.phone,
    );
  }

 /* Widget setPasswordTextField(String placeholder, controller, bool enable) {
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
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: CommonStyle.getAppFont(
              color: CommonColors.primaryColor,
              fontWeight: FontWeight.w400,
              fontSize: 16.0),
          contentPadding: EdgeInsets.only(left: 10, right: 10, top: 10),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: CommonColors.primaryColor,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
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

  Widget setPasswordTextField(String placeholder, controller, bool enable) {
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
        textInputAction: TextInputAction.next,
        enabled: enable,
        cursorColor: CommonColors.dark_6060,
        controller: controller,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: CommonStyle.getAppFont(
              color: CommonColors.dark_6060,
              fontWeight: FontWeight.w300,
              fontSize: 14.0),
          contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10),
          border: InputBorder.none,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: CommonColors.dark_6060.withOpacity(.4),
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),
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

  void _openCountryCodePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => ChooseCountryDialog(
        title: S.of(context).countryCode,
        countryList: mViewModel.countryList,
        onCountrySelected: (CountryDetails country) {
          Navigator.pop(context);
          mViewModel.selectedCountry = country;
          mViewModel.notifyListeners();
        },
      ),
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
          print("countrycode => " + country.countyCode.toString());
          mViewModel.notifyListeners();
        },
      ),
    );
  }

  bool isValid() {
    if (mFirstNameController.text.isEmpty) {
      CommonUtils.showSnackBar(
          S.of(context).enterFirstName, mViewModel.scaffoldKey);
      return false;
    } else if (mLastNameController.text.isEmpty) {
      CommonUtils.showSnackBar(
          S.of(context).enterLastName, mViewModel.scaffoldKey);
      return false;
    } else if (mMobileController.text.isEmpty) {
      CommonUtils.showSnackBar(
          S.of(context).enterMobileNumber, mViewModel.scaffoldKey);
      return false;
    } else if (mEmailController.text.isEmpty) {
      CommonUtils.showSnackBar(
          S.of(context).enterEmailAddress, mViewModel.scaffoldKey);
      return false;
    } else if (!CommonUtils.isvalidEmail(mEmailController.text)) {
      CommonUtils.showSnackBar(
          S.of(context).enterValidEmailAddress, mViewModel.scaffoldKey);
      return false;
    } else if (mPasswordController.text.isEmpty) {
      CommonUtils.showSnackBar(
          S.of(context).enterPassword, mViewModel.scaffoldKey);
      return false;
    }/* else if (mViewModel.selectedDate.isEmpty) {
      CommonUtils.showSnackBar(
          S.of(context).chooseDateOfBirth, mViewModel.scaffoldKey);
      return false;
    }*/ else {
      return true;
    }
  }
}
