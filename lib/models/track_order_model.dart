class TrackOrderMaster {
  int _success;
  String _message;
  List<TrackOrderDetails> _result;

  TrackOrderMaster(
      {int success, String message, List<TrackOrderDetails> result}) {
    this._success = success;
    this._message = message;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  List<TrackOrderDetails> get result => _result;
  set result(List<TrackOrderDetails> result) => _result = result;

  TrackOrderMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'].toString().replaceAll('labels.', ' ');
    if (json['result'] != null) {
      _result = new List<TrackOrderDetails>();
      json['result'].forEach((v) {
        _result.add(new TrackOrderDetails.fromJson(v));
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

class TrackOrderDetails {
  int _orderStatusHistoryId;
  int _orderId;
  int _orderStatusId;
  String _date;
  String _status;
  String _comments;
  bool _isStatusComplete;

  TrackOrderDetails(
      {int orderStatusHistoryId,
      int orderId,
      int orderStatusId,
      String date,
      String status,
      String comments,
      bool isStatusComplete}) {
    this._orderStatusHistoryId = orderStatusHistoryId;
    this._orderId = orderId;
    this._orderStatusId = orderStatusId;
    this._date = date;
    this._status = status;
    this._comments = comments;
    this._isStatusComplete = isStatusComplete;
  }

  int get orderStatusHistoryId => _orderStatusHistoryId;
  set orderStatusHistoryId(int orderStatusHistoryId) =>
      _orderStatusHistoryId = orderStatusHistoryId;
  int get orderId => _orderId;
  set orderId(int orderId) => _orderId = orderId;
  int get orderStatusId => _orderStatusId;
  set orderStatusId(int orderStatusId) => _orderStatusId = orderStatusId;
  String get date => _date;
  set date(String date) => _date = date;
  String get status => _status;
  set status(String status) => _status = status;
  String get comments => _comments;
  set comments(String comments) => _comments = comments;

  bool get isStatusComplete => _isStatusComplete;

  set isStatusComplete(bool value) {
    _isStatusComplete = value;
  }

  TrackOrderDetails.fromJson(Map<String, dynamic> json) {
    _orderStatusHistoryId = json['orderStatusHistoryId'];
    _orderId = json['orderId'];
    _orderStatusId = json['orderStatusId'];
    _date = json['Date'];
    _status = json['status'];
    _comments = json['comments'];
    _isStatusComplete = json['isStatusComplete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderStatusHistoryId'] = this._orderStatusHistoryId;
    data['orderId'] = this._orderId;
    data['orderStatusId'] = this._orderStatusId;
    data['Date'] = this._date;
    data['status'] = this._status;
    data['comments'] = this._comments;
    data['isStatusComplete'] = this._isStatusComplete;
    return data;
  }
}
