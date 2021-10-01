import 'package:big_mart/utils/constant.dart';
import 'package:big_mart/views/product_detail/product_details_view.dart';
import 'package:big_mart/widgets/custom_dialog/MyCustomDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../generated/i18n.dart';
import 'common_colors.dart';

class CommonUtils {
  static bool isShowing = false;
  static String langugeCode = AppConstants.LANGUAGE_ENGLISH;

  static Widget getListItemProgressBar() {
    return new Center(
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(20.0),
        child: new Center(
          child: new SpinKitWave(
            size: 35,
            color: Colors.orangeAccent,
          ),
        ),
      ),
    );
  }

  static bool isEmpty(String string) {
    return string == null || string.length == 0;
  }

  static bool isvalidEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(email)) ? false : true;
  }

  static void showSnackBar(String message, globalKey, {color}) {
    final snackBar = SnackBar(
      backgroundColor: color ?? Colors.red,
      content: Text(message),
      duration: Duration(seconds: 1),
    );
    globalKey.currentState.showSnackBar(snackBar);
  }

  static void showProgressDialog(BuildContext context) {
    MyCustomDialog changePasswordDialog = MyCustomDialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      //this right here
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Center(
              child: SpinKitRing(
                color: Colors.orangeAccent,
                size: 50.0,
                lineWidth: 4,
              ),
            )
          ],
        ),
      ),
    );

    if (!isShowing) {
      showMyDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return changePasswordDialog;
          });
      isShowing = true;
    }
  }

  static void hideProgressDialog(BuildContext context) {
    if (isShowing) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      isShowing = false;
    }
  }

  static void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showGreenToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.orangeAccent,
        textColor: CommonColors.white,
        fontSize: 16.0);
  }

  static void showRedToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.orangeAccent,
        textColor: CommonColors.white,
        fontSize: 16.0);
  }

  static hideKeyboard(context) {
    try {
      FocusScope.of(context).unfocus();
    } catch (e) {}
  }

  static Future<void> scanBarcodeNormal(BuildContext context) async {
    String barcodeScanRes, productId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      productId = barcodeScanRes;
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    print("barcode result: " + barcodeScanRes.toString());
    if (!isEmpty(productId)) {
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              pageBuilder: (_, __, ___) => ProductDetailsView(
                productId: productId,
              )));
    }
  }

  static String getStatus(int status, BuildContext context) {
    String _status = "";
    if (status != null) {
      if (status == 1) {
        _status = S.of(context).pending;
      } else if (status == 2) {
        _status = S.of(context).completed;
      } else if (status == 3) {
        _status = S.of(context).cancelled;
      } else if (status == 4) {
        _status = S.of(context).status_return;
      }
    }
    return _status;
  }
}
