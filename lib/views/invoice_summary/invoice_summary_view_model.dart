import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/models/invoice_master.dart';
import 'package:big_mart/models/message.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InvoiceSummaryViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode;
  LoginDetails loginDetails;
  InvoiceDetails invoiceDetails;
  double rating = 1.0;

  void attachContext(BuildContext context) {
    mContext = context;
    invoiceDetails = null;
    notifyListeners();
  }

  void getInvoiceDetails(String orderId) async {
    notifyListeners();

    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    InvoiceDetailsMaster master = await _services.invoiceDetails(
        languageCode: languageCode,
        customerId:
        loginDetails != null ? loginDetails.customerId.toString() : "",
        orderId: orderId
    );
    if (master != null) {
      if (master.success == 1) {
        if (master.result != null) {
          invoiceDetails = master.result;
        }
      }
    }
    notifyListeners();
  }

  void sendInvoice({String orderId}) async {
    CommonUtils.showProgressDialog(mContext);
    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    if (loginDetails != null) {
      MessageMaster master = await _services.sendInvoice(
          languageCode: languageCode,
          orderId: orderId,);
      CommonUtils.hideProgressDialog(mContext);
      if (master != null) {
        if (master.success == 1) {
          CommonUtils.showGreenToastMessage(master.message.toString());
        }
        else {
          CommonUtils.showRedToastMessage(master.message.toString());
        }
      }
    }
  }
}
