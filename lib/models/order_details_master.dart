import 'order_master.dart';

class OrderDetailsMaster {
  int _success;
  String _message;
  OrderDetailsResult _result;

  OrderDetailsMaster({int success, String message, OrderDetailsResult result}) {
    this._success = success;
    this._message = message;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  OrderDetailsResult get result => _result;
  set result(OrderDetailsResult result) => _result = result;

  OrderDetailsMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'].toString().replaceAll('labels.', ' ');
    _result =
    json['result'] != null ? new OrderDetailsResult.fromJson(json['result']) : null;
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

class OrderDetailsResult {
  int _orderId;
  String _shipTo;
  String _orderDate;
  String _email;
  String _phoneNo;
  String _deliveredTo;
  String _invoice;
  int _status;
  List<OrderProduct> _product;

  OrderDetailsResult(
      {int orderId,
        String shipTo,
        String orderDate,
        String email,
        String phoneNo,
        String deliveredTo,
        String invoice,
        int status,
        List<OrderProduct> product}) {
    this._orderId = orderId;
    this._shipTo = shipTo;
    this._orderDate = orderDate;
    this._email = email;
    this._phoneNo = phoneNo;
    this._deliveredTo = deliveredTo;
    this._invoice = invoice;
    this._status = status;
    this._product = product;
  }

  int get orderId => _orderId;
  set orderId(int orderId) => _orderId = orderId;
  String get shipTo => _shipTo;
  set shipTo(String shipTo) => _shipTo = shipTo;
  String get orderDate => _orderDate;
  set orderDate(String orderDate) => _orderDate = orderDate;
  String get email => _email;
  set email(String email) => _email = email;
  String get phoneNo => _phoneNo;
  set phoneNo(String phoneNo) => _phoneNo = phoneNo;
  String get deliveredTo => _deliveredTo;
  set deliveredTo(String deliveredTo) => _deliveredTo = deliveredTo;
  String get invoice => _invoice;
  set invoice(String invoice) => _invoice = invoice;
  int get status => _status;
  set status(int status) => _status = status;
  List<OrderProduct> get product => _product;
  set product(List<OrderProduct> product) => _product = product;

  OrderDetailsResult.fromJson(Map<String, dynamic> json) {
    _orderId = json['orderId'];
    _shipTo = json['shipTo'];
    _orderDate = json['orderDate'];
    _email = json['email'];
    _phoneNo = json['phoneNo'];
    _deliveredTo = json['deliveredTo'];
    _invoice = json['invoice'];
    _status = json['status'];
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
    data['shipTo'] = this._shipTo;
    data['orderDate'] = this._orderDate;
    data['email'] = this._email;
    data['phoneNo'] = this._phoneNo;
    data['deliveredTo'] = this._deliveredTo;
    data['invoice'] = this._invoice;
    data['status'] = this._status;
    if (this._product != null) {
      data['product'] = this._product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}