class ProductMaster {
  int _success;
  List<ProductData> _productData;
  String _message;
  int _totalRecord;

  ProductMaster(
      {int success,
        List<ProductData> productData,
        String message,
        int totalRecord}) {
    this._success = success;
    this._productData = productData;
    this._message = message;
    this._totalRecord = totalRecord;
  }

  int get success => _success;
  set success(int success) => _success = success;
  List<ProductData> get productData => _productData;
  set productData(List<ProductData> productData) => _productData = productData;
  String get message => _message;
  set message(String message) => _message = message;
  int get totalRecord => _totalRecord;
  set totalRecord(int totalRecord) => _totalRecord = totalRecord;

  ProductMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    if (json['product_data'] != null) {
      _productData = new List<ProductData>();
      json['product_data'].forEach((v) {
        _productData.add(new ProductData.fromJson(v));
      });
    }
    _message = json['message'].toString().replaceAll('labels.', ' ');
    _totalRecord = json['total_record'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    if (this._productData != null) {
      data['product_data']  = this._productData.map((v) => v.toJson()).toList();
     /* data['product_data']  = this._productData.map((v) => v).toList();*/
    }
    data['message'] = this._message;
    data['total_record'] = this._totalRecord;
    return data;
  }
}

class ProductData {
  int _prouductId;
  String _productName;
  String _productPrice;
  String _productOriginalPrice;
  String _productsImage;
  int _productOfferPercentage;
  bool _productLiked;

  ProductData(
      {int prouductId,
        String productName,
        String productPrice,
        String productOriginalPrice,
        String productsImage,
        int productOfferPercentage,
        bool productLiked}) {
    this._prouductId = prouductId;
    this._productName = productName;
    this._productPrice = productPrice;
    this._productOriginalPrice = productOriginalPrice;
    this._productsImage = productsImage;
    this._productOfferPercentage = productOfferPercentage;
    this._productLiked = productLiked;
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
  String get productsImage => _productsImage;
  set productsImage(String productsImage) => _productsImage = productsImage;
  int get productOfferPercentage => _productOfferPercentage;
  set productOfferPercentage(int productOfferPercentage) =>
      _productOfferPercentage = productOfferPercentage;
  bool get productLiked => _productLiked;
  set productLiked(bool productLiked) => _productLiked = productLiked;

  ProductData.fromJson(Map<String, dynamic> json) {
    _prouductId = json['prouductId'];
    _productName = json['productName'];
    _productPrice = json['productPrice'];
    _productOriginalPrice = json['productOriginalPrice'];
    _productsImage = json['productsImage'];
    _productOfferPercentage = json['productOfferPercentage'];
    _productLiked = json['productLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prouductId'] = this._prouductId;
    data['productName'] = this._productName;
    data['productPrice'] = this._productPrice;
    data['productOriginalPrice'] = this._productOriginalPrice;
    data['productsImage'] = this._productsImage;
    data['productOfferPercentage'] = this._productOfferPercentage;
    data['productLiked'] = this._productLiked;
    return data;
  }
}