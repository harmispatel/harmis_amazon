import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/forgot_password/forgot_password_view.dart';
import 'package:big_mart/views/forgot_password/forgot_password_view_web.dart';
import 'package:big_mart/views/register/register_view_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_view_model.dart';

class LoginViewWeb extends StatefulWidget {
  @override
  _LoginViewWebState createState() => _LoginViewWebState();
}

class _LoginViewWebState extends State<LoginViewWeb> {
  final globalKey = new GlobalKey();
  LoginViewModel mViewModel;
  bool _passwordVisible = false;
  TextEditingController mEmailController = new TextEditingController();
  TextEditingController mPasswordController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<LoginViewModel>(context, listen: false);
      mViewModel.attachContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<LoginViewModel>(context);
    final tvLoginToAccount = Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 16),
      child: Text(
        S.of(context).loginToYourAccount,
        style: CommonStyle.getAppFont(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: CommonColors.primaryColor),
      ),
    );

    final tvForgotPassword = InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 1),
                pageBuilder: (_, __, ___) => ForgotPasswordViewWeb()));
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 5, right: 8),
        alignment: Alignment.centerRight,
        child: Text(
          S.of(context).forgotPassword,
          style: CommonStyle.getAppFont(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: CommonColors.primaryColor),
        ),
      ),
    );

    final layoutRegister = InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 1),
                pageBuilder: (_, __, ___) => RegisterViewWeb()));
      },
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).doNotHaveAccount,
              style: CommonStyle.getAppFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: CommonColors.color_515c6f),
            ),
            Text(
              S.of(context).register,
              style: CommonStyle.getAppFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: CommonColors.primaryColor),
            ),
          ],
        ),
      ),
    );

    final btnConfirm = InkWell(
      onTap: () {
        if (isValid()) {
          mViewModel.loginApi(
              email: mEmailController.text, password: mPasswordController.text);
        }

        /*Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 1),
                pageBuilder: (_, __, ___) => bottomNavigationBar()));*/
      },
      child: Container(
        margin: EdgeInsets.only(top: 12),
        height: 40,
        width: MediaQuery.of(context).size.width * 0.1,
        decoration: BoxDecoration(
            color: CommonColors.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(4)),
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
            S.of(context).confirm,
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
        backgroundColor: CommonColors.white,
        elevation: 0.0,
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.only(left: 4),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  height: 15,
                  child: Image.asset(LocalImages.ic_arrow_back),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 25),
              height: 35,
              child: Image.asset(LocalImages.ic_header_logo),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.28,
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1.0,
                    offset: Offset.zero,
                    blurRadius: 1.0)
              ]),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    tvLoginToAccount,
                    setTextField(
                        S.of(context).emailOrPhone, mEmailController, true),
                    setPasswordTextField(
                        S.of(context).password, mPasswordController, true),
                    tvForgotPassword,
                    btnConfirm,
                  ]),
            ),
            layoutRegister,
          ],
        ),
      ),
    );
  }

  Widget setTextField(String placeholder, controller, bool enable) {
    return Container(
      height: 45,
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8, left: 8),
      decoration: BoxDecoration(
          color: CommonColors.primaryLight,
          border: Border(
              bottom: BorderSide(color: CommonColors.primaryColor, width: 1))),
      child: TextField(
        cursorColor: CommonColors.primaryColor,
        enabled: enable,
        controller: controller,
        decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: CommonStyle.getAppFont(
                color: CommonColors.primaryColor,
                fontWeight: FontWeight.w400,
                fontSize: 16.0),
            contentPadding: EdgeInsets.only(left: 10, right: 10),
            border: InputBorder.none),
        style: CommonStyle.getAppFont(
            color: CommonColors.primaryColor,
            fontWeight: FontWeight.w400,
            fontSize: 16.0),
        maxLines: 1,
        autocorrect: false,
      ),
    );
  }

  Widget setPasswordTextField(String placeholder, controller, bool enable) {
    return Container(
      height: 45,
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8, right: 8),
      decoration: BoxDecoration(
          color: CommonColors.primaryLight,
          border: Border(
              bottom: BorderSide(color: CommonColors.primaryColor, width: 1))),
      child: TextField(
        cursorColor: CommonColors.primaryColor,
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
  }

  bool isValid() {
    if (mEmailController.text.isEmpty) {
      CommonUtils.showSnackBar(S.of(context).enterEmailAddress, globalKey);
      return false;
    } /*else if (!CommonUtils.isvalidEmail(mEmailController.text)) {
      CommonUtils.showSnackBar(S.of(context).enterValidEmailAddress, globalKey);
      return false;
    }*/
    else if (mPasswordController.text.isEmpty) {
      CommonUtils.showSnackBar(S.of(context).enterPassword, globalKey);
      return false;
    } else {
      return true;
    }
  }
}
