/*class ProductDetailsMaster {
  int _success;
  String _message;
  ProductDetails _result;

  ProductDetailsMaster({int success, String message, ProductDetails result}) {
    this._success = success;
    this._message = message;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  ProductDetails get result => _result;
  set result(ProductDetails result) => _result = result;

  ProductDetailsMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'];
    _result =
    json['result'] != null ? new ProductDetails.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['message'] = this._message;
    if (this._result != null) {
      data['result'] = this._result.toJson();
    }
    return data;
  }
}

class ProductDetails {
  int _prouductId;
  String _productName;
  String _productPrice;
  String _productOriginalPrice;
  int _productOfferPercentage;
  String _productImage;
  bool _productLiked;
  String _scheduledDelivery;
  String _barcodeImage;
  List<Review> _review;
  List<String> _bannerImage;

  ProductDetails(
      {int prouductId,
        String productName,
        String productPrice,
        String productOriginalPrice,
        int productOfferPercentage,
        String productImage,
        bool productLiked,
        String scheduledDelivery,
        String barcodeImage,
        List<Review> review,
        List<String> bannerImage,
      }) {
    this._prouductId = prouductId;
    this._productName = productName;
    this._productPrice = productPrice;
    this._productOriginalPrice = productOriginalPrice;
    this._productOfferPercentage = productOfferPercentage;
    this._productImage = productImage;
    this._productLiked = productLiked;
    this._scheduledDelivery = scheduledDelivery;
    this._barcodeImage = barcodeImage;
    this._bannerImage = bannerImage;
    this._review = review;
  }

  int get prouductId => _prouductId;
  set prouductId(int prouductId) => _prouductId = prouductId;
  String get productName => _productName;
  set productName(String productName) => _productName = productName;
  String get productPrice => _productPrice;
  set productPrice(String productPrice) => _productPrice = productPrice;
  String get productOriginalPrice => _productOriginalPrice;
  set productOriginalPrice(String productOriginalPrice) =>
      _productOriginalPrice = productOriginalPrice;
  int get productOfferPercentage => _productOfferPercentage;
  set productOfferPercentage(int productOfferPercentage) =>
      _productOfferPercentage = productOfferPercentage;
  String get productImage => _productImage;
  set productImage(String productImage) => _productImage = productImage;
  bool get productLiked => _productLiked;
  set productLiked(bool productLiked) => _productLiked = productLiked;

  String get scheduledDelivery => _scheduledDelivery;

  set scheduledDelivery(String scheduledDelivery) {
    _scheduledDelivery = scheduledDelivery;
  }

  String get barcodeImage => _barcodeImage;

  set barcodeImage(String barcodeImage) {
    _barcodeImage = barcodeImage;
  }

  List<Review> get review => _review;
  set review(List<Review> review) => _review = review;

  List<String> get bannerImage => _bannerImage;

  set bannerImage(List<String> bannerImage) {
    _bannerImage = bannerImage;
  }

  ProductDetails.fromJson(Map<String, dynamic> json) {
    _prouductId = json['prouductId'];
    _productName = json['productName'];
    _productPrice = json['productPrice'];
    _productOriginalPrice = json['productOriginalPrice'];
    _productOfferPercentage = json['productOfferPercentage'];
    _productImage = json['productImage'];
    _productLiked = json['productLiked'];
    _scheduledDelivery = json['ScheduledDelivery'];
    _barcodeImage = json['barcodeImage'];
    _bannerImage = json['bannerimg'] != null ? json['bannerimg'].cast<String>() : null;
    if (json['review'] != null) {
      _review = new List<Review>();
      json['review'].forEach((v) {
        _review.add(new Review.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prouductId'] = this._prouductId;
    data['productName'] = this._productName;
    data['productPrice'] = this._productPrice;
    data['productOriginalPrice'] = this._productOriginalPrice;
    data['productOfferPercentage'] = this._productOfferPercentage;
    data['productImage'] = this._productImage;
    data['productLiked'] = this._productLiked;
    data['ScheduledDelivery'] = this._scheduledDelivery;
    data['barcodeImage'] = this._barcodeImage;
    data['bannerimg'] = this._bannerImage;
    if (this._review != null) {
      data['review'] = this._review.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Review {
  String _customerName;
  String _customerPicture;
  String _reviewText;

  Review({String customerName, String customerPicture, String reviewText}) {
    this._customerName = customerName;
    this._customerPicture = customerPicture;
    this._reviewText = reviewText;
  }

  String get customerName => _customerName;
  set customerName(String customerName) => _customerName = customerName;
  String get customerPicture => _customerPicture;
  set customerPicture(String customerPicture) =>
      _customerPicture = customerPicture;
  String get reviewText => _reviewText;
  set reviewText(String reviewText) => _reviewText = reviewText;

  Review.fromJson(Map<String, dynamic> json) {
    _customerName = json['customerName'];
    _customerPicture = json['customerPicture'];
    _reviewText = json['reviewText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerName'] = this._customerName;
    data['customerPicture'] = this._customerPicture;
    data['reviewText'] = this._reviewText;
    return data;
  }
}*/

import 'package:big_mart/models/message.dart';

class ProductDetailsMaster {
  int _success;
  String _message;
  Result _result;

  ProductDetailsMaster({int success, String message, Result result}) {
    this._success = success;
    this._message = message;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  Result get result => _result;
  set result(Result result) => _result = result;

  ProductDetailsMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'].toString().replaceAll('labels.', ' ');
    _result = json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['message'] = this._message;
    if (this._result != null) {
      data['result'] = this._result.toJson();
    }
    return data;
  }
}

class Result {
  int _prouductId;
  String _productName;
  String _productPrice;
  String _productOriginalPrice;
  Null _productOfferPercentage;
  String _productDescription;
  String _scheduledDelivery;
  bool _productLiked;
  String _productImage;
  Option _option;
  List<Review> _review;
  List<String> _bannerimg;
  bool _isSelected;

  Result(
      {int prouductId,
        String productName,
        String productPrice,
        String productOriginalPrice,
        Null productOfferPercentage,
        String productDescription,
        String scheduledDelivery,
        bool productLiked,
        String productImage,
        Option option,
        List<Review> review,
        List<String> bannerimg,
        bool isSelected}) {
    this._prouductId = prouductId;
    this._productName = productName;
    this._productPrice = productPrice;
    this._productOriginalPrice = productOriginalPrice;
    this._productOfferPercentage = productOfferPercentage;
    this._productDescription = productDescription;
    this._scheduledDelivery = scheduledDelivery;
    this._productLiked = productLiked;
    this._productImage = productImage;
    this._option = option;
    this._review = review;
    this._bannerimg = bannerimg;
    this._isSelected = isSelected;
  }

  int get prouductId => _prouductId;
  set prouductId(int prouductId) => _prouductId = prouductId;
  String get productName => _productName;
  set productName(String productName) => _productName = productName;
  String get productPrice => _productPrice;
  set productPrice(String productPrice) => _productPrice = productPrice;
  String get productOriginalPrice => _productOriginalPrice;
  set productOriginalPrice(String productOriginalPrice) =>
      _productOriginalPrice = productOriginalPrice;
  Null get productOfferPercentage => _productOfferPercentage;
  set productOfferPercentage(Null productOfferPercentage) =>
      _productOfferPercentage = productOfferPercentage;
  String get productDescription => _productDescription;
  set productDescription(String productDescription) =>
      _productDescription = productDescription;
  String get scheduledDelivery => _scheduledDelivery;
  set scheduledDelivery(String scheduledDelivery) =>
      _scheduledDelivery = scheduledDelivery;
  bool get productLiked => _productLiked;
  set productLiked(bool productLiked) => _productLiked = productLiked;
  String get productImage => _productImage;
  set productImage(String productImage) => _productImage = productImage;
  Option get option => _option;
  set option(Option option) => _option = option;
  List<Review> get review => _review;
  set review(List<Review> review) => _review = review;
  List<String> get bannerimg => _bannerimg;
  set bannerimg(List<String> bannerimg) => _bannerimg = bannerimg;
  bool get isSelected => _isSelected?? false;
  set isSelected(bool isSelected) => _isSelected = isSelected;

  Result.fromJson(Map<String, dynamic> json) {
    _prouductId = json['prouductId'];
    _productName = json['productName'];
    _productPrice = json['productPrice'];
    _productOriginalPrice = json['productOriginalPrice'];
    _productOfferPercentage = json['productOfferPercentage'];
    _productDescription = json['productDescription'];
    _scheduledDelivery = json['ScheduledDelivery'];
    _productLiked = json['productLiked'];
    _productImage = json['productImage'];
    _isSelected = json['isSelected'];
    _option = json['option'] != null ? !(json['option'] is String) ? new Option.fromJson(json['option']) : null : null;
    if (json['review'] != null) {
      _review = new List<Review>();
      json['review'].forEach((v) {
        _review.add((new Review.fromJson(v)));
      });
    }
    _bannerimg = json['bannerimg'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prouductId'] = this._prouductId;
    data['productName'] = this._productName;
    data['productPrice'] = this._productPrice;
    data['productOriginalPrice'] = this._productOriginalPrice;
    data['productOfferPercentage'] = this._productOfferPercentage;
    data['productDescription'] = this._productDescription;
    data['ScheduledDelivery'] = this._scheduledDelivery;
    data['productLiked'] = this._productLiked;
    data['productImage'] = this._productImage;
    data['isSelected'] = this._isSelected;
    if (this._option != null) {
      data['option'] = this._option.toJson();
    }
    if (this._review != null) {
      data['review'] = this._review.map((v) => v).toList();
    }
    data['bannerimg'] = this._bannerimg;
    return data;
  }
}

class Option {
  List<Attributes> _attributes;

  Option({List<Attributes> attributes}) {
    this._attributes = attributes;
  }

  List<Attributes> get attributes => _attributes;
  set attributes(List<Attributes> attributes) => _attributes = attributes;

  Option.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      _attributes = new List<Attributes>();
      json['attributes'].forEach((v) {
        _attributes.add(new Attributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._attributes != null) {
      data['attributes'] = this._attributes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attributes {
  Option _option;
  List<Values> _values;

  Attributes({Option option, List<Values> values}) {
    this._option = option;
    this._values = values;
  }

  Option get option => _option;
  set option(Option option) => _option = option;
  List<Values> get values => _values;
  set values(List<Values> values) => _values = values;

  Attributes.fromJson(Map<String, dynamic> json) {
    _option =
    json['option'] != null ? new Option.fromJson(json['option']) : null;
    if (json['values'] != null) {
      _values = new List<Values>();
      json['values'].forEach((v) {
        _values.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._option != null) {
      data['option'] = this._option.toJson();
    }
    if (this._values != null) {
      data['values'] = this._values.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int _id;
  String _name;
  int _isDefault;

  Option({int id, String name, int isDefault}) {
    this._id = id;
    this._name = name;
    this._isDefault = isDefault;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  int get isDefault => _isDefault;
  set isDefault(int isDefault) => _isDefault = isDefault;

  Options.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['is_default'] = this._isDefault;
    return data;
  }
}

class Values {
  int _productsAttributesId;
  int _id;
  String _value;
  String _price;
  String _pricePrefix;
  bool _isSelected;

  Values(
      {int productsAttributesId,
        int id,
        String value,
        String price,
        String pricePrefix,
        bool isSelected}) {
    this._productsAttributesId = productsAttributesId;
    this._id = id;
    this._value = value;
    this._price = price;
    this._pricePrefix = pricePrefix;
    this._isSelected = isSelected;
  }

  int get productsAttributesId => _productsAttributesId;
  set productsAttributesId(int productsAttributesId) =>
      _productsAttributesId = productsAttributesId;
  int get id => _id;
  set id(int id) => _id = id;
  String get value => _value;
  set value(String value) => _value = value;
  String get price => _price;
  set price(String price) => _price = price;
  String get pricePrefix => _pricePrefix;
  set pricePrefix(String pricePrefix) => _pricePrefix = pricePrefix;
  bool get isSelected => _isSelected;
  set isSelected(bool isSelected) => _isSelected = isSelected;

  Values.fromJson(Map<String, dynamic> json) {
    _productsAttributesId = json['products_attributes_id'];
    _id = json['id'];
    _value = json['value'];
    _price = json['price'];
    _pricePrefix = json['price_prefix'];
    _isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products_attributes_id'] = this._productsAttributesId;
    data['id'] = this._id;
    data['value'] = this._value;
    data['price'] = this._price;
    data['price_prefix'] = this._pricePrefix;
    data['isSelected'] = this._isSelected;
    return data;
  }

}
class Review {
  String _customerName;
  String _customerPicture;
  String _reviewText;

  Review({String customerName, String customerPicture, String reviewText}) {
    this._customerName = customerName;
    this._customerPicture = customerPicture;
    this._reviewText = reviewText;
  }

  String get customerName => _customerName;

  set customerName(String customerName) => _customerName = customerName;

  String get customerPicture => _customerPicture;

  set customerPicture(String customerPicture) =>
      _customerPicture = customerPicture;

  String get reviewText => _reviewText;

  set reviewText(String reviewText) => _reviewText = reviewText;

  Review.fromJson(Map<String, dynamic> json) {
    _customerName = json['customerName'];
    _customerPicture = json['customerPicture'];
    _reviewText = json['reviewText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerName'] = this._customerName;
    data['customerPicture'] = this._customerPicture;
    data['reviewText'] = this._reviewText;
    return data;
  }
}