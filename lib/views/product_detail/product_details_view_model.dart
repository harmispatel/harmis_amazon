import 'dart:io';
import 'dart:typed_data';

import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/cart_master.dart';
import 'package:big_mart/models/message.dart';
import 'package:big_mart/models/product_details.dart';
import 'package:big_mart/models/product_master.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/api_url.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:big_mart/utils/local_images.dart';
import 'package:big_mart/views/my_orders/my_orders_view.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:big_mart/widgets/bottom_nav_bar/bottom_nav_bar_view_model.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class ProductDetailsViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode, deviceToken;
  LoginDetails loginDetails;
  ProductDetailsMaster productDetails;
  double rating = 1.0;
  int value;
  List<String> imageList = new List();
  double productPrice;
  int onsizepressed = 0;
  int oncolorpressed = 0;
  double productSizePrice;
  double productColorPrice;
  // List<Color> colorList = [];
  // List<String> sizeList = [];


  bool isSimilarProductsLoading = true;
  List<ProductData> similarProductList = new List();
/*
  void getvalue(color,size){
    print("Value of color"+color.toString());
    print("Value of size"+size.toString());
    productPrice = double.parse(productDetails.result.productPrice);
    double newPrice = double.parse(color.toString())+double.parse(size.toString());
    productPrice+=newPrice;
    notifyListeners();
  }*/

  void getvalue(color,size){
    /*print("Value of color"+color.toString());
    print("Value of size"+size.toString());*/
    productPrice = double.parse(productDetails.result.productPrice);
    if(size==null){
      double newofColorPrice = double.parse(color.toString())+double.parse(productSizePrice.toString());
      productPrice+=newofColorPrice;
    }else if(color==null){
      double newofSizePrice = double.parse(productColorPrice.toString())+double.parse(size.toString());
      productPrice+=newofSizePrice;
    }else{
      double newPrice = double.parse(color.toString())+double.parse(size.toString());
      productPrice+=newPrice;
    }
    notifyListeners();
  }


  void getsize(val){
    print("Size"+val.toString());
    productSizePrice = double.parse(val);
    notifyListeners();
  }

  void getColor(val) {
    print("Color==>"+val.toString());
    productColorPrice = double.parse(val);
    notifyListeners();
  }

  Future<void> attachContext(BuildContext context) async {
    mContext = context;
    productDetails = null;
    // colorList.add(CommonColors.white);
    // colorList.add(CommonColors.dark_blue);
    //
    // sizeList.add('XXS');
    // sizeList.add('XS');
    // sizeList.add('S');
    // sizeList.add('M');
    // sizeList.add('L');
    // sizeList.add('XL');
    // sizeList.add('XXL');

    notifyListeners();
  }

  void getProductDetails(String productId) async {
    imageList.clear();
    notifyListeners();

    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    productDetails = await _services.getProductDetails(
        languageCode: languageCode,
        customerId:
            loginDetails != null ? loginDetails.customerId.toString() : "",
        productId: productId);
    if (productDetails != null) {
      // print("kjfdskjf");
      if (productDetails.success == 1) {
        if (productDetails.result != null) {
          imageList.add(productDetails.result.productImage);
          /*productPrice = double.parse(productDetails.result.productPrice);
          print("your color is:"+productDetails.result.option.attributes[0].values[0].price);
          print("your size is:"+productDetails.result.option.attributes[1].values[0].price);*/
         /* double newvalue = double.parse(productDetails.result.option.attributes[0].values[0].price)+double.parse(productDetails.result.option.attributes[1].values[0].price);
         *//* print("new value of addition:"+newvalue);*//*
          productPrice+=newvalue;*/
          if(productDetails.result.option!=null) {
            productSizePrice = double.parse(
                productDetails.result.option.attributes[1].values[0].price);
            productColorPrice = double.parse(
                productDetails.result.option.attributes[0].values[0].price);
            getvalue(productDetails.result.option.attributes[0].values[0].price,
                productDetails.result.option.attributes[1].values[0].price);
          }
          if (productDetails.result.bannerimg != null &&
              productDetails.result.bannerimg.length > 0) {
            for (String img in productDetails.result.bannerimg) {
              if (img != null && img != "" && img != "null") imageList.add(img);
            }
          }
        } else {
          CommonUtils.showRedToastMessage(productDetails.message.toString());
          Navigator.pop(mContext);
        }
      } else {
        CommonUtils.showRedToastMessage(productDetails.message.toString());
        Navigator.pop(mContext);
      }
    } else {
      Navigator.pop(mContext);
    }
    notifyListeners();
  }

  void getDealsProductList(String productId) async {
    //if (similarProductList.length == 0) {
    isSimilarProductsLoading = true;
    similarProductList.clear();
    notifyListeners();

    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    ProductMaster master = await _services.similarProducts(
        languageCode: languageCode,
        productId: productId,
        customerId:
            loginDetails != null ? loginDetails.customerId.toString() : "");
    isSimilarProductsLoading = false;
    if (master != null) {
      if (master.productData != null && master.productData.length > 0) {
        similarProductList.addAll(master.productData);
      }
    }
    notifyListeners();
    //}
  }

  void addRemoveFromWishList(
      {String productId, bool isAdd, Function onSuccess}) async {
    CommonUtils.showProgressDialog(mContext);
    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    if (loginDetails != null) {
      MessageMaster master = await _services.addRemoveFromWishlist(
        languageCode: languageCode,
        userId: loginDetails != null ? loginDetails.customerId.toString() : "",
        productId: productId,
        isType: isAdd ? "1" : "0",
      );
      if (master != null) {
        if (master.success == 1) {
          //CommonUtils.showGreenToastMessage(master.message.toString());
          onSuccess();
        } else {
          CommonUtils.showRedToastMessage(master.message.toString());
        }
      }
    }
    CommonUtils.hideProgressDialog(mContext);
    notifyListeners();
  }

  void addToCart({String productId}) async {
    CommonUtils.showProgressDialog(mContext);
    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    deviceToken = await appPreferences.getDeviceToken();
    MessageMaster master = await _services.addToCart(
      languageCode: languageCode,
      customerId:
          loginDetails != null ? loginDetails.customerId.toString() : "",
      productId: productId,
      deviceId: deviceToken,
    );
    if (master != null) {
      if (master.success == 1) {
      await  _popupDialog(mContext);
        Provider.of<BottomNavBarViewModel>(mContext, listen: false)
            .getCartList();
      } else {
        CommonUtils.showRedToastMessage(master.message.toString());
      }
    }
    CommonUtils.hideProgressDialog(mContext);
    notifyListeners();
  }

  void writeReviewApi({reviewText, rating}) async {
    CommonUtils.showProgressDialog(mContext);
    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    if (loginDetails != null) {
      MessageMaster master = await _services.addReview(
          languageCode: languageCode,
          customerId: loginDetails.customerId.toString(),
          customerName: loginDetails.firstName.toString() +
              " " + loginDetails.lastName.toString(),
          productId: productDetails.result.prouductId.toString(),
          rating: rating.toString(),
          review: reviewText);
      CommonUtils.hideProgressDialog(mContext);
      if (master != null) {
        if (master.success == 1) {
          print("review added API "+master.message);
              getProductDetails(productDetails.result.prouductId.toString());
        } else {
          CommonUtils.showRedToastMessage(master.message.toString());
        }
      }
    }
  }

  Future<void> shareImageWithText(BuildContext context) async {
    if (productDetails != null) {
      CommonUtils.showProgressDialog(context);
      var request =
          await HttpClient().getUrl(Uri.parse(productDetails.result.productImage));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      CommonUtils.hideProgressDialog(context);

      await WcFlutterShare.share(
          sharePopupTitle: 'share',
          subject: 'Please download this app',
          text: productDetails.result.productName +
              "\n" +
              productDetails.result.productPrice +
              "IQ" +
              "\n" +
              S.of(context).downloadAppNow +
              "\n https://play.google.com/store/apps/details?id=com.big_mart",
          fileName: 'share.png',
          mimeType: 'image/png',
          bytesOfFile: bytes.buffer.asUint8List());
    }
  }
  void webShare() async {
    /* FlutterClipboard.copy(
            "https://play.google.com/store/apps/details?id=com.big_mart")
        .then((value) {
      print('copy to clipboard sucessfully!');
      CommonUtils.showGreenToastMessage("Copy sucessfully");
    });*/
    await launch(
      "http://basratimes-shops.com/api/",
      /*languageCode != null &&
          languageCode ==
              AppConstants.LANGUAGE_ENGLISH
          ? ApiUrl.BASE_URL
          : ApiUrl.ABOUT_US_AR,*/
      forceSafariVC: false,
      forceWebView: false,
    );
  }

  Future <void> _popupDialog(BuildContext context) {
  return  showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(borderRadius:
            BorderRadius.all(Radius.circular(18))),
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(LocalImages.ic_dialog,height: 160,width: 160,),
                      SizedBox(height: 2,),
                      Text(S.of(context).success,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(S.of(context).your,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 14),textAlign: TextAlign.center,),
                      ),
                      InkWell(
                        onTap: (){
                          /*Navigator.of(context)
                            .pushNamedAndRemoveUntil('/bottomNavigationBar', (Route<dynamic> route) => false);*/
                         /* Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                                builder: (context) => bottomNavigationBar(),
                              ), (route) => false);*/

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) => bottomNavigationBar()),
                                  (Route<dynamic> route) => false
                          );
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width - 150,
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Center(
                            child: Text(S.of(context).cont,
                              style: TextStyle(
                                  color: CommonColors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return MyOrdersView();
                                  }));
                            },
                            child: Text(S.of(context).gotoorders,
                              style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 18),)),
                      ),
                    ],
                  )
              )
            ],
          );
        });
  }
}
