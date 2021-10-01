import 'package:big_mart/models/order_master.dart';

class InvoiceDetailsMaster {
  int _success;
  String _message;
  InvoiceDetails _result;

  InvoiceDetailsMaster({int success, String message, InvoiceDetails result}) {
    this._success = success;
    this._message = message;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  InvoiceDetails get result => _result;
  set result(InvoiceDetails result) => _result = result;

  InvoiceDetailsMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'].toString().replaceAll('labels.', ' ');
    _result =
    json['result'] != null ? new InvoiceDetails.fromJson(json['result']) : null;
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

class InvoiceDetails {
  int _orderId;
  String _orderPrice;
  String _shippingCost;
  String _totalTax;
  String _orderDate;
  String _shipTo;
  String _email;
  String _phoneNo;
  String _deliveredTo;
  String _status;
  double _subTotal;
  List<OrderProduct> _product;

  InvoiceDetails(
      {int orderId,
        String orderPrice,
        String shippingCost,
        String totalTax,
        String orderDate,
        String shipTo,
        String email,
        String phoneNo,
        String deliveredTo,
        String status,
        double subTotal,
        List<OrderProduct> product}) {
    this._orderId = orderId;
    this._orderPrice = orderPrice;
    this._shippingCost = shippingCost;
    this._totalTax = totalTax;
    this._orderDate = orderDate;
    this._shipTo = shipTo;
    this._email = email;
    this._phoneNo = phoneNo;
    this._deliveredTo = deliveredTo;
    this._status = status;
    this._subTotal = subTotal;
    this._product = product;
  }

  int get orderId => _orderId;
  set orderId(int orderId) => _orderId = orderId;
  String get orderPrice => _orderPrice;
  set orderPrice(String orderPrice) => _orderPrice = orderPrice;
  String get shippingCost => _shippingCost;
  set shippingCost(String shippingCost) => _shippingCost = shippingCost;
  String get totalTax => _totalTax;
  set totalTax(String totalTax) => _totalTax = totalTax;
  String get orderDate => _orderDate;
  set orderDate(String orderDate) => _orderDate = orderDate;
  String get shipTo => _shipTo;
  set shipTo(String shipTo) => _shipTo = shipTo;
  String get email => _email;
  set email(String email) => _email = email;
  String get phoneNo => _phoneNo;
  set phoneNo(String phoneNo) => _phoneNo = phoneNo;
  String get deliveredTo => _deliveredTo;
  set deliveredTo(String deliveredTo) => _deliveredTo = deliveredTo;
  String get status => _status;
  set status(String status) => _status = status;
  double get subTotal => _subTotal;
  set subTotal(double subTotal) => _subTotal = subTotal;
  List<OrderProduct> get product => _product;
  set product(List<OrderProduct> product) => _product = product;

  InvoiceDetails.fromJson(Map<String, dynamic> json) {
    _orderId = json['orderId'];
    _orderPrice = json['orderPrice'];
    _shippingCost = json['shippingCost'];
    _totalTax = json['totalTax'];
    _orderDate = json['orderDate'];
    _shipTo = json['shipTo'];
    _email = json['email'];
    _phoneNo = json['phoneNo'];
    _deliveredTo = json['deliveredTo'];
    _status = json['status'];
    _subTotal = json['subTotal'] != null ? json['subTotal'].toDouble() : 0.0;
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
    data['orderPrice'] = this._orderPrice;
    data['shippingCost'] = this._shippingCost;
    data['totalTax'] = this._totalTax;
    data['orderDate'] = this._orderDate;
    data['shipTo'] = this._shipTo;
    data['email'] = this._email;
    data['phoneNo'] = this._phoneNo;
    data['deliveredTo'] = this._deliveredTo;
    data['status'] = this._status;
    data['subTotal'] = this._subTotal;
    if (this._product != null) {
      data['product'] = this._product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}