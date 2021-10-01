import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/models/category.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class CategoriesViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode;
  List<CategoryDetails> categoryList = new List();
  int selectedCategoryIndex = 0;
  bool isApiLoading = true;
  String message = "";

  void attachContext(BuildContext context) {
    mContext = context;
  }
  void clearList() {
    categoryList.clear();
  }

  void initCategoryList() async {
    /*if (categoryList.length == 0) {*/
      categoryList.clear();
      selectedCategoryIndex = 0;
      isApiLoading = true;
      notifyListeners();

      languageCode = await appPreferences.getLanguageCode();
      CategoryMaster master = await _services.categoryList(
          languageCode: languageCode);
      isApiLoading = false;
      if (master != null) {
        if (master.success == 1) {
          if (master.result != null && master.result.length > 0) {
            categoryList.addAll(master.result);
            categoryList[0].isSelected = true;
          }
        }
        else {
          message = master.message ?? "";
        }
      }
      notifyListeners();
    }
  }

  Future<void> startBarcode() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE)
        .listen((barcode) {
      print("Start Barcode result: " + barcode);
    });
  }



