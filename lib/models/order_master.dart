class OrderMaster {
  int _success;
  String _message;
  List<OrderDetails> _result;

  OrderMaster({int success, String message, List<OrderDetails> result}) {
    this._success = success;
    this._message = message;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  List<OrderDetails> get result => _result;
  set result(List<OrderDetails> result) => _result = result;

  OrderMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'].replaceAll('labels.',' ');
    if (json['result'] != null) {
      _result = new List<OrderDetails>();
      json['result'].forEach((v) {
        _result.add(new OrderDetails.fromJson(v));
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

class OrderDetails {
  int _orderId;
  int _status;
  String _purchaseDate;
  List<OrderProduct> _product;

  OrderDetails(
      {int orderId, int status, String purchaseDate, List<OrderProduct> product}) {
    this._orderId = orderId;
    this._status = status;
    this._purchaseDate = purchaseDate;
    this._product = product;
  }

  int get orderId => _orderId;
  set orderId(int orderId) => _orderId = orderId;
  int get status => _status;
  set status(int status) => _status = status;
  String get purchaseDate => _purchaseDate;
  set purchaseDate(String purchaseDate) => _purchaseDate = purchaseDate;
  List<OrderProduct> get product => _product;
  set product(List<OrderProduct> product) => _product = product;

  OrderDetails.fromJson(Map<String, dynamic> json) {
    _orderId = json['orderId'];
    _status = json['status'];
    _purchaseDate = json['purchaseDate'];
    if (json['product'] != null) {
      _product = new List<OrderProduct>();
      json['product'].forEach((v) {
        _product.add(new OrderProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this._orderId;
    data['status'] = this._status;
    data['purchaseDate'] = this._purchaseDate;
    if (this._product != null) {
      data['product'] = this._product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderProduct {
  int _productId;
  String _productName;
  String _productPrice;
  String _image;
  int _productQty;

  OrderProduct(
      {int productId,
        String productName,
        String productPrice,
        String image,
        int productQty}) {
    this._productId = productId;
    this._productName = productName;
    this._productPrice = productPrice;
    this._image = image;
    this._productQty = productQty;
  }

  int get productId => _productId;
  set productId(int productId) => _productId = productId;
  String get productName => _productName;
  set productName(String productName) => _productName = productName;
  String get productPrice => _productPrice;
  set productPrice(String productPrice) => _productPrice = productPrice;
  String get image => _image;
  set image(String image) => _image = image;
  int get productQty => _productQty;
  set productQty(int productQty) => _productQty = productQty;

  OrderProduct.fromJson(Map<String, dynamic> json) {
    _productId = json['productId'];
    _productName = json['productName'];
    _productPrice = json['productPrice'];
    _image = json['image'];
    _productQty = json['productQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this._productId;
    data['productName'] = this._productName;
    data['productPrice'] = this._productPrice;
    data['image'] = this._image;
    data['productQty'] = this._productQty;
    return data;
  }
}