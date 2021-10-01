import 'package:big_mart/models/product_master.dart';

class FavouriteMaster {
  int _success;
  String _message;
  List<ProductData> _result;

  FavouriteMaster({int success, String message, List<ProductData> result}) {
    this._success = success;
    this._message = message;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  List<ProductData> get result => _result;
  set result(List<ProductData> result) => _result = result;

  FavouriteMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'].toString().replaceAll('labels.', ' ');
    if (json['result'] != null) {
      _result = new List<ProductData>();
      json['result'].forEach((v) {
        _result.add(new ProductData.fromJson(v));
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