/*class BrandMaster {
  int _success;
  String _message;
  List<BrandDetails> _result;

  BrandMaster({int success, String message, List<BrandDetails> result}) {
    this._success = success;
    this._message = message;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  List<BrandDetails> get result => _result;
  set result(List<BrandDetails> result) => _result = result;

  BrandMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = new List<BrandDetails>();
      json['result'].forEach((v) {
        _result.add(new BrandDetails.fromJson(v));
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

class BrandDetails {
  int _id;
  String _brandsSlug;
  String _dateAdded;
  String _lastModified;
  String _brandName;
  int _productCount;
  bool _isSelected;

  BrandDetails(
      {int id,
        String brandsSlug,
        String dateAdded,
        String lastModified,
        String brandName,
        int productCount,
        bool isSelected}) {
    this._id = id;
    this._brandsSlug = brandsSlug;
    this._dateAdded = dateAdded;
    this._lastModified = lastModified;
    this._brandName = brandName;
    this._productCount = productCount;
    this._isSelected = isSelected;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get brandsSlug => _brandsSlug;
  set brandsSlug(String brandsSlug) => _brandsSlug = brandsSlug;
  String get dateAdded => _dateAdded;
  set dateAdded(String dateAdded) => _dateAdded = dateAdded;
  String get lastModified => _lastModified;
  set lastModified(String lastModified) => _lastModified = lastModified;
  String get brandName => _brandName;
  set brandName(String brandName) => _brandName = brandName;
  int get productCount => _productCount;
  set productCount(int productCount) => _productCount = productCount;
  bool get isSelected => _isSelected?? false;
  set isSelected(bool isSelected) => _isSelected = isSelected;

  BrandDetails.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _brandsSlug = json['brandsSlug'];
    _dateAdded = json['dateAdded'];
    _lastModified = json['lastModified'];
    _brandName = json['brandName'];
    _productCount = json['productCount'];
    _isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['brandsSlug'] = this._brandsSlug;
    data['dateAdded'] = this._dateAdded;
    data['lastModified'] = this._lastModified;
    data['brandName'] = this._brandName;
    data['productCount'] = this._productCount;
    data['isSelected'] = this._isSelected;
    return data;
  }
}*/





class BrandMaster {
  int _success;
  String _message;
  List<BrandDetails> _result;

  BrandMaster({int success, String message, List<BrandDetails> result}) {
    this._success = success;
    this._message = message;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  List<BrandDetails> get result => _result;
  set result(List<BrandDetails> result) => _result = result;

  BrandMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = new List<BrandDetails>();
      json['result'].forEach((v) {
        _result.add(new BrandDetails.fromJson(v));
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

class BrandDetails {
  int _id;
  String _name;
  bool _isSelected;

  Result({int id, String name,bool isSelected}) {
    this._id = id;
    this._name = name;
    this._isSelected = isSelected;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  bool get isSelected => _isSelected?? false;
  set isSelected(bool isSelected) => _isSelected = isSelected;

  BrandDetails.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['isSelected'] = this._isSelected;
    return data;
  }
}