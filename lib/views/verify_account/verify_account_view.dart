import 'dart:async';

import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/signup_request.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/widgets/pin_view_custom/pin_view_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'verify_account_view_model.dart';

class VerifyAccountView extends StatefulWidget {
  final String mobileNumber;
  final String verificationId;

  final SignUpRequest signUpRequest;

  VerifyAccountView(
      {this.mobileNumber, this.verificationId, this.signUpRequest});

  @override
  _VerifyAccountViewState createState() => _VerifyAccountViewState();
}

class _VerifyAccountViewState extends State<VerifyAccountView> {
  VerifyAccountViewModel mViewModel;
  Timer _timer;
  int _timerSeconds = 60;
  bool isButtonEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<VerifyAccountViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      startTimer();
    });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_timerSeconds < 1) {
            isButtonEnabled = true;
            timer.cancel();
          } else {
            _timerSeconds = _timerSeconds - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    if (_timer != null) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<VerifyAccountViewModel>(context);
    final tvLoginToAccount = Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 16),
      child: Text(
        S.of(context).verifyYourAccount,
        style: CommonStyle.getAppFont(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: CommonColors.dark_6060),
      ),
    );

    final layoutCodeSentTo = Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).enterTheCode,
            style: CommonStyle.getAppFont(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: CommonColors.color_515c6f),
          ),
          SizedBox(
            height: 4,
          ),
          /*Text(
            "p***7@gmail.com",
            style: CommonStyle.getAppFont(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: CommonColors.primaryColor),
          ),*/
        ],
      ),
    );

    final tvResendCode = InkWell(
      onTap: () {
        if (isButtonEnabled) {
          // send opt API, and on success of it set isButtonEnabled to false and _timerSeconds to 60 and startTimer();
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 16),
        alignment: Alignment.center,
        child: Text(
          S.of(context).resendCode,
          style: CommonStyle.getAppFont(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: CommonColors.dark_6060),
        ),
      ),
    );

    final pinView = PinEntryTextField(
      fields: 6,
      onSubmit: (String pin) {
        mViewModel.otpCode = pin;
        print("PIN: " + pin);
      }, // end onSubmit
    );

    final btnSubmit = InkWell(
      onTap: () {
        if (isValid()) {
          /* mViewModel.verifyAccount(
              id: widget.registerDetails.customersId.toString());*/
          mViewModel.phoneSignIn(
              phoneNUmber: widget.signUpRequest.phoneCode + widget.mobileNumber,
              smsOTP: mViewModel.otpCode,
              context: context,
              vid: widget.verificationId,
              signupRequest: widget.signUpRequest);
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
            S.of(context).submit.toUpperCase(),
            style: CommonStyle.getAppFont(
                color: CommonColors.white,
                fontSize: 18,
                letterSpacing: 1,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );

    final tvSeconds = Padding(
      padding: EdgeInsets.only(top: 16),
      child: Text(
        _timerSeconds > 0
            ? _timerSeconds.toString() + " " + S.of(context).seconds
            : "",
        textAlign: TextAlign.center,
        style: CommonStyle.getAppFont(
          color: CommonColors.dark_6060,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );

    return Scaffold(
      key: mViewModel.scaffoldKey,
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
                    height: 27,
                    child: Image.asset(LocalImages.ic_amazon_logo,),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            tvLoginToAccount,
            layoutCodeSentTo,
            //tvResendCode,
            pinView,
            btnSubmit,
            tvSeconds
          ],
        ),
      ),
    );
  }

  bool isValid() {
    if (mViewModel.otpCode.isEmpty) {
      CommonUtils.showToastMessage(S.of(context).pleaseEnterOtpCode);
      return false;
    } else {
      return true;
    }
  }
}
