import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forgot_password_view_model.dart';

class ForgotPasswordViewWeb extends StatefulWidget {
  @override
  _ForgotPasswordViewWebState createState() => _ForgotPasswordViewWebState();
}

class _ForgotPasswordViewWebState extends State<ForgotPasswordViewWeb> {
  final globalKey = new GlobalKey();
  ForgotPasswordViewModel mViewModel;
  TextEditingController mEmailController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<ForgotPasswordViewModel>(context, listen: false);
      mViewModel.attachContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<ForgotPasswordViewModel>(context);
    final tvLoginToAccount = Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 16),
      child: Text(
        S.of(context).forgotPassword,
        style: CommonStyle.getAppFont(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: CommonColors.primaryColor),
      ),
    );

    final btnConfirm = InkWell(
      onTap: () {
        if (isValid()) {
          mViewModel.forgotPasswordApi(email: mEmailController.text);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.1,
        margin: EdgeInsets.only(top: 12),
        height: 40,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 25),
                child: Container(
                  height: 35,
                  child: Image.asset(LocalImages.ic_header_logo),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.28,
                height: MediaQuery.of(context).size.height * 0.35,
                padding: EdgeInsets.only(left: 8, right: 8),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1.0,
                      offset: Offset.zero,
                      blurRadius: 1.0)
                ]),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      tvLoginToAccount,
                      setTextField(
                          S.of(context).emailAddress, mEmailController, true),
                      btnConfirm,
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget setTextField(String placeholder, controller, bool enable) {
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
  }

  bool isValid() {
    if (mEmailController.text.isEmpty) {
      CommonUtils.showSnackBar(S.of(context).enterEmailAddress, globalKey);
      return false;
    } else if (!CommonUtils.isvalidEmail(mEmailController.text)) {
      CommonUtils.showSnackBar(S.of(context).enterValidEmailAddress, globalKey);
      return false;
    } else {
      return true;
    }
  }
}
