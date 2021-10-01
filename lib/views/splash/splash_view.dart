import 'dart:io';

import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/models/app.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/views/splash/splash_view_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashView> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  SplashViewModel mViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Splash screen");
    _firebaseMessaging.getToken().then((String token) {
      print("Firebase token: " + token);
      AppPreferences().setDeviceToken(token);
    });
    Future.delayed(Duration.zero, () {
        mViewModel = Provider.of<SplashViewModel>(context, listen: false);
        mViewModel.startTimer(context);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SplashViewModel>(context);

    final mBody = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            //mViewModel.redirectToLogin(context);
          },
          child: Hero(
              tag: "logo",
              child: Container(
                padding: EdgeInsets.all(16),
                // child: Image.asset(LocalImages.ic_amazon_logo,height: 120,width: 120,)
                child: Text("logo",style: TextStyle(color:Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
              )),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: CommonColors.white,
      body: Stack(
        children: [
          Align(alignment: Alignment.center, child: mBody),
        ],
      ),
    );
  }
}
