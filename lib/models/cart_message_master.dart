class CartMessageMaster {
  int _success;
  String _message;
  String _totalprice;

  CartMessageMaster({int success, String message, String totalprice}) {
    this._success = success;
    this._message = message;
    this._totalprice = totalprice;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  String get totalprice => _totalprice;
  set totalprice(String totalprice) => _totalprice = totalprice;

  CartMessageMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'].toString().replaceAll('labels.', '');
    _totalprice = json['totalprice'] != null ? json['totalprice'].toString() : "0.0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['message'] = this._message;
    data['totalprice'] = this._totalprice;
    return data;
  }
}