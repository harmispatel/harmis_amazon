class CartMaster {
  int _success;
  String _message;
  String _totalprice;
  List<CartDetails> _result;

  CartMaster(
      {int success,
      String message,
      String totalprice,
      List<CartDetails> result}) {
    this._success = success;
    this._message = message;
    this._totalprice = totalprice;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  String get totalprice => _totalprice;
  set totalprice(String totalprice) => _totalprice = totalprice;
  List<CartDetails> get result => _result;
  set result(List<CartDetails> result) => _result = result;

  CartMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'].toString().replaceAll('labels.', '');
    _totalprice =
        json['totalprice'] != null ? json['totalprice'].toString() : "0.0";
    if (json['result'] != null) {
      _result = new List<CartDetails>();
      json['result'].forEach((v) {
        _result.add(new CartDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['message'] = this._message;
    data['totalprice'] = this._totalprice;
    if (this._result != null) {
      data['result'] = this._result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartDetails {
  int _prouductId;
  int _customerBasketId;
  int _customerBasketQuantity;
  String _productName;
  String _productPrice;
  String _productFinalPrice;
  int _productOfferPercentage;
  String _productsImage;
  String _productOriginalPrice;
  int _offlineId;

  CartDetails(
      {int prouductId,
      int customerBasketId,
      int customerBasketQuantity,
      String productName,
      String productPrice,
      String productFinalPrice,
      int productOfferPercentage,
      String productsImage}) {
    this._prouductId = prouductId;
    this._customerBasketId = customerBasketId;
    this._customerBasketQuantity = customerBasketQuantity;
    this._productName = productName;
    this._productPrice = productPrice;
    this._productFinalPrice = productFinalPrice;
    this._productOfferPercentage = productOfferPercentage;
    this._productsImage = productsImage;
  }

  int get offlineId => _offlineId;

  set offlineId(int value) {
    _offlineId = value;
  }

  String get productOriginalPrice => _productOriginalPrice;

  set productOriginalPrice(String value) {
    _productOriginalPrice = value;
  }

  int get prouductId => _prouductId;
  set prouductId(int prouductId) => _prouductId = prouductId;
  int get customerBasketId => _customerBasketId;
  set customerBasketId(int customerBasketId) =>
      _customerBasketId = customerBasketId;
  int get customerBasketQuantity => _customerBasketQuantity;
  set customerBasketQuantity(int customerBasketQuantity) =>
      _customerBasketQuantity = customerBasketQuantity;
  String get productName => _productName;
  set productName(String productName) => _productName = productName;
  String get productPrice => _productPrice;
  set productPrice(String productPrice) => _productPrice = productPrice;
  String get productFinalPrice => _productFinalPrice;
  set productFinalPrice(String productFinalPrice) =>
      _productFinalPrice = productFinalPrice;
  int get productOfferPercentage => _productOfferPercentage;
  set productOfferPercentage(int productOfferPercentage) =>
      _productOfferPercentage = productOfferPercentage;
  String get productsImage => _productsImage;
  set productsImage(String productsImage) => _productsImage = productsImage;

  CartDetails.fromJson(Map<String, dynamic> json) {
    _prouductId = json['prouductId'];
    _customerBasketId = json['customerBasketId'];
    _customerBasketQuantity = json['customerBasketQuantity'];
    _productName = json['productName'];
    _productPrice = json['productPrice'];
    _productOriginalPrice = json['productOriginalPrice'];
    _productFinalPrice = json['productFinalPrice'];
    _productOfferPercentage = json['productOfferPercentage'];
    _productsImage = json['productsImage'];
    _offlineId = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prouductId'] = this._prouductId;
    data['customerBasketId'] = this._customerBasketId;
    data['customerBasketQuantity'] = this._customerBasketQuantity;
    data['productName'] = this._productName;
    data['productPrice'] = this._productPrice;
    data['productOriginalPrice'] = this._productOriginalPrice;
    data['productFinalPrice'] = this._productFinalPrice;
    data['productOfferPercentage'] = this._productOfferPercentage;
    data['productsImage'] = this._productsImage;
    data['id'] = this._offlineId;
    return data;
  }
}
