import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/forgot_password/forgot_password_view.dart';
import 'package:big_mart/views/register/register_view.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:provider/provider.dart';

import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
   /* final tvLoginToAccount = Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 16),
      child: Text(
        S.of(context).loginToYourAccount,
        style: CommonStyle.getAppFont(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: CommonColors.primaryColor),
      ),
    );*/

    final tvLoginToAccount = Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 16),
      child: Text(
        "Login",
        style: CommonStyle.getAppFont(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: CommonColors.dark_6060),
      ),
    );

  /*  final tvForgotPassword = InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 1),
                pageBuilder: (_, __, ___) => ForgotPasswordView()));
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 5),
        alignment: Alignment.centerRight,
        child: Text(
          S.of(context).forgotPassword,
          style: CommonStyle.getAppFont(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: CommonColors.primaryColor),
        ),
      ),
    );*/

    final tvForgotPassword = InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 1),
                pageBuilder: (_, __, ___) => ForgotPasswordView()));
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 5),
        alignment: Alignment.centerRight,
        child: Text(
          S.of(context).forgotPassword,
          style: CommonStyle.getAppFont(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: CommonColors.dark_6060),
        ),
      ),
    );

    final layoutRegister = InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 1),
                pageBuilder: (_, __, ___) => RegisterView()));
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
                  color: CommonColors.dark_6060),
            ),
          ],
        ),
      ),
    );

   /* final btnConfirm = InkWell(
      onTap: () {
        if (isValid()) {
          mViewModel.loginApi(
              email: mEmailController.text, password: mPasswordController.text);
        }

        *//*Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 1),
                pageBuilder: (_, __, ___) => bottomNavigationBar()));*//*
      },
      child: Container(
        margin: EdgeInsets.only(top: 12),
        height: 50,
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
    );*/

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
        margin: EdgeInsets.only(top: 35),
        height: 50,
        decoration: BoxDecoration(
            color: Colors.orangeAccent.withOpacity(0.9),
            borderRadius: BorderRadius.all(Radius.circular(30)),
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
            "Login",
            style: CommonStyle.getAppFont(
                color: CommonColors.white,
                fontSize: 18,
                letterSpacing: 1,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );

    final googleLogin = InkWell(
      onTap: (){
        // mViewModel.logoutgoogle();
        mViewModel.signingoogle();

      },
      child: Container(
        height: 45,
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
        child:Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: Container(
                  height: 25,
                  child: Image.asset("assets/img/ic_google__logo.png")),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Text("Signin with google",
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15),),
            ),
          ],
        ),

      ),
    );

    final facebookLogin = InkWell(
      onTap: () async{
        // await mViewModel.logoutFacebook();
        await mViewModel.handleLogin();
        },
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          height: 45,
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
          child:Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 30),
                child: Container(
                    height: 30,
                    child: Image.asset("assets/img/ic_face.png",)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Text("Signin with Facebook",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15),),
              ),
            ],
          ),
        ),
      ),
    );




   /* return Scaffold(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(
                        builder: (context) => bottomNavigationBar(),
                      ), (route) => false);
                },
                icon: Container(
                  height: 15,
                  child: Image.asset(LocalImages.ic_arrow_back),
                ),
              ),
             *//* Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 35,
                    child: Image.asset(LocalImages.ic_header_logo),
                  ),
                ),
              ),*//*
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 25,
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
            tvLoginToAccount,
            setTextField(S.of(context).emailOrPhone, mEmailController, true),
            setPasswordTextField(
                S.of(context).password, mPasswordController, true),
            tvForgotPassword,
            btnConfirm,
            layoutRegister,
          ],
        ),
      ),
    );*/

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(
                        builder: (context) => bottomNavigationBar(),
                      ), (route) => false);

                  // Navigator.popAndPushNamed(context, '/bottomNavigationBar');
                },
                icon: Container(
                  height: 15,
                  child: Image.asset(LocalImages.ic_arrow_back,color: Colors.black,),
                ),
              ),
              /* Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 35,
                    child: Image.asset(LocalImages.ic_header_logo),
                  ),
                ),
              ),*/
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
            tvLoginToAccount,
            setTextField(S.of(context).emailOrPhone, mEmailController, true),
            setPasswordTextField(
                S.of(context).password, mPasswordController, true),
            tvForgotPassword,
            btnConfirm,
            layoutRegister,
            SizedBox(height: 20),
            googleLogin,
            facebookLogin
          ],
        ),
      ),
    );
  }

 /* Widget setTextField(String placeholder, controller, bool enable) {
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
        textInputAction: TextInputAction.next,
          enabled: enable,
          cursorColor: CommonColors.dark_6060,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: placeholder,
            hintStyle: CommonStyle.getAppFont(
                color: CommonColors.dark_6060,
                fontWeight: FontWeight.w300,
                fontSize: 14.0),
            contentPadding: EdgeInsets.only(left: 20, right: 20,bottom: 5),
          ),
          style: CommonStyle.getAppFont(
              color: CommonColors.dark_6060,
              fontWeight: FontWeight.w300,
              fontSize: 16.0),
          maxLines: 1,
          autocorrect: false,
      ),
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
          border: InputBorder.none,
          hintText: placeholder,
          hintStyle: CommonStyle.getAppFont(
              color: CommonColors.dark_6060,
              fontWeight: FontWeight.w300,
              fontSize: 14.0),
          contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10),
          suffixIcon: IconButton(
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
        style: CommonStyle.getAppFont(
            color: CommonColors.dark_6060,
            fontWeight: FontWeight.w300,
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
