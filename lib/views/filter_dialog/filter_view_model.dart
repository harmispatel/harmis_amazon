import 'dart:convert';

import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/models/brand_master.dart';
import 'package:big_mart/models/category.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:flutter/cupertino.dart';

class FilterViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode;
  List<CategoryDetails> categoryList = new List();
  List<BrandDetails> brandList = new List();

  FilterModel filterModel;

  void attachContext(BuildContext context) {
    mContext = context;
  }

  void getCategoryList() async {
    filterModel = await appPreferences.getFilter();
    if (categoryList.length == 0) {
      categoryList.clear();
      notifyListeners();

      languageCode = await appPreferences.getLanguageCode();
      CategoryMaster master =
          await _services.categoryList(languageCode: languageCode);
      if (master != null) {
        if (master.success == 1) {
          if (master.result != null && master.result.length > 0) {
            categoryList.addAll(master.result);
          }
        }
      }
    }
    setFiltersCategory();
    notifyListeners();
  }

  void getBrandList() async {
    filterModel = await appPreferences.getFilter();
    if (brandList.length == 0) {
      brandList.clear();
      notifyListeners();

      languageCode = await appPreferences.getLanguageCode();
      BrandMaster master =
          await _services.brandList(languageCode: languageCode);
      if (master != null) {
        if (master.success == 1) {
          if (master.result != null && master.result.length > 0) {
            brandList.addAll(master.result);
          }
        }
      }
    }
    setFiltersBrand();
    notifyListeners();
  }

  void selectOrUnselectBrand(int index) {
    brandList[index].isSelected = !brandList[index].isSelected;
    notifyListeners();
  }

  void selectCategory(int index) {
    categoryList[index].isSelected = !categoryList[index].isSelected;
    notifyListeners();
  }

  void setFiltersCategory() {
    for (int i = 0; i < categoryList.length; i++) {
      categoryList[i].isSelected = false;
    }
    if (filterModel != null) {
      List<String> categories = filterModel.categories.split(",");
      for (int i = 0; i < categoryList.length; i++) {
        for (String category in categories) {
          categoryList[i].isSelected = false;
          if (category == categoryList[i].categoriesId.toString()) {
            categoryList[i].isSelected = true;
          }
        }
      }
    }
  }

  void setFiltersBrand() {
    for (int i = 0; i < brandList.length; i++) {
      brandList[i].isSelected = false;
    }
    if (filterModel != null) {
      List<String> categories = filterModel.brands.split(",");
      for (int i = 0; i < brandList.length; i++) {
        for (String category in categories) {
          brandList[i].isSelected = false;
          if (category == brandList[i].id.toString()) {
            brandList[i].isSelected = true;
          }
        }
      }
    }
  }

  void applyFilter(
      {Function onApplyFilter}) async {
    FilterModel filterModel = new FilterModel();
    filterModel.categories = getSelectedCategories();
    filterModel.brands = getSelectedBrand();
    appPreferences.setFilter(json.encode(filterModel.toJson()));
    onApplyFilter();
  }

  String getSelectedCategories() {
    String categories = "";
    for (int i = 0; i < categoryList.length; i++) {
      if (categoryList[i].isSelected) {
        categories += categoryList[i].categoriesId.toString() + ",";
      }
    }
    return categories.isNotEmpty
        ? categories.substring(0, categories.length - 1)
        : "";
  }

  String getSelectedBrand() {
    String brands = "";
    for (int i = 0; i < brandList.length; i++) {
      if (brandList[i].isSelected) {
        brands += brandList[i].id.toString() + ",";
      }
    }
    return brands.isNotEmpty ? brands.substring(0, brands.length - 1) : "";
  }
}

class FilterModel {
  String categories = "";
  String brands = "";

  FilterModel();

  FilterModel.fromJson(Map<String, dynamic> json) {
    categories = json['categories'];
    brands = json['brands'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categories'] = this.categories;
    data['brands'] = this.brands;
    return data;
  }
}
