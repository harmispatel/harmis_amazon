class CategoryMaster {
  int _success;
  String _message;
  List<CategoryDetails> _result;

  CategoryMaster({int success, String message, List<CategoryDetails> result}) {
    this._success = success;
    this._message = message;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  List<CategoryDetails> get result => _result;
  set result(List<CategoryDetails> result) => _result = result;

  CategoryMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'].toString().replaceAll("labels.", '');
    if (json['result'] != null) {
      _result = new List<CategoryDetails>();
      json['result'].forEach((v) {
        _result.add(new CategoryDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['message'] = this._message;
    if (this._result != null) {
      data['result'] = this._result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryDetails {
  int _categoriesId;
  String _categoriesImg;
  String _categoriesIcon;
  String _categoriesSortOrder;
  String _categoriesSlug;
  String _color;
  bool _isSelected;

  CategoryDetails(
      {int categoriesId,
      String categoriesImg,
      String categoriesIcon,
      String categoriesSortOrder,
      String categoriesSlug,
      String color,
      bool isSelected}) {
    this._categoriesId = categoriesId;
    this._categoriesImg = categoriesImg;
    this._categoriesIcon = categoriesIcon;
    this._categoriesSortOrder = categoriesSortOrder;
    this._categoriesSlug = categoriesSlug;
    this._color = color;
    this._isSelected = isSelected;
  }

  int get categoriesId => _categoriesId;
  set categoriesId(int categoriesId) => _categoriesId = categoriesId;
  String get categoriesImg => _categoriesImg;
  set categoriesImg(String categoriesImg) => _categoriesImg = categoriesImg;
  String get categoriesIcon => _categoriesIcon;
  set categoriesIcon(String categoriesIcon) => _categoriesIcon = categoriesIcon;

  String get categoriesSortOrder => _categoriesSortOrder;

  set categoriesSortOrder(String value) {
    _categoriesSortOrder = value;
  }

  String get categoriesSlug => _categoriesSlug;
  set categoriesSlug(String categoriesSlug) => _categoriesSlug = categoriesSlug;

  String get color => _color;

  set color(String color) {
    _color = color;
  }

  bool get isSelected => _isSelected ?? false;
  set isSelected(bool isSelected) => _isSelected = isSelected;

  CategoryDetails.fromJson(Map<String, dynamic> json) {
    _categoriesId = json['categoriesId'];
    _categoriesImg = json['categoriesImg'];
    _categoriesIcon = json['categoriesIcon'];
    _categoriesSortOrder = json['categoriesSortOrder'].toString();
    _categoriesSlug = json['categoriesName'];
    _color = json['color'];
    _isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoriesId'] = this._categoriesId;
    data['categoriesImg'] = this._categoriesImg;
    data['categoriesIcon'] = this._categoriesIcon;
    data['categoriesSortOrder'] = this._categoriesSortOrder;
    data['categoriesName'] = this._categoriesSlug;
    data['color'] = this._color;
    data['isSelected'] = this._isSelected;
    return data;
  }
}
