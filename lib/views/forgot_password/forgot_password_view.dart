import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forgot_password_view_model.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
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
            color: CommonColors.dark_6060),
      ),
    );

    final btnConfirm = InkWell(
      onTap: () {
        if (isValid()) {
          mViewModel.forgotPasswordApi(email: mEmailController.text);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 12),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            tvLoginToAccount,
            setTextField(S.of(context).emailAddress, mEmailController, true),
            btnConfirm,
          ],
        ),
      ),
    );
  }


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
        controller: controller,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: CommonStyle.getAppFont(
              color: CommonColors.dark_6060,
              fontWeight: FontWeight.w300,
              fontSize: 14.0),
          contentPadding: EdgeInsets.only(left: 20, right: 10,bottom: 5),
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
