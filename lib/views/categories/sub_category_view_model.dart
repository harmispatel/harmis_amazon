import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/models/category.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:flutter/cupertino.dart';

class SubCategoryViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode;
  List<CategoryDetails> subCategoryList = new List();
  bool isApiLoading = false;
  String message = "";

  void attachContext(BuildContext context) {
    mContext = context;
  }

  void initSubCategoryList(String categoryId) async {
    message = "No sub category found";
    subCategoryList.clear();
    isApiLoading = true;
    notifyListeners();

    languageCode = await appPreferences.getLanguageCode();
    CategoryMaster master = await _services.subCategoryList(languageCode: languageCode, categoryId: categoryId);
    isApiLoading = false;
    if (master != null) {
      if (master.success == 1) {
        if (master.result != null && master.result.length > 0) {
          subCategoryList.addAll(master.result);
        }
      } else {
        message = master.message?? "";
      }
    }
    notifyListeners();
  }
}