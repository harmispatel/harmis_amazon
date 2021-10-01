/*class AddressDetails {
  bool _isSelected;

  AddressDetails({bool isSelected}){
    this._isSelected = isSelected;
  }

  bool get isSelected => _isSelected?? false;

  set isSelected(bool value) {
    _isSelected = value;
  }
}*/


class AddressDetailsMaster {
  int _success;
  String _message;
  List<AddressDetails> _result;

  AddressDetailsMaster({int success, String message, List<AddressDetails> result}) {
    this._success = success;
    this._message = message;
    this._result = result;

  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  List<AddressDetails> get result => _result;
  set result(List<AddressDetails> result) => _result = result;

  AddressDetailsMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'].toString().replaceAll('labels.', '');
    if (json['result'] != null) {
      _result = new List<AddressDetails>();
      json['result'].forEach((v) {
        _result.add(new AddressDetails.fromJson(v));
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

class AddressDetails {
  bool _isSelected;
  int _addressId;
  int _customerId;
  String _firstName;
  String _address;
  String _postCode;
  String _city;
  String _mobile;
  String _area;
  String _lat;
  String _lng;
  String _blokNumber;
  String _deviceType;
  String _landmark;

  AddressDetails(
      {
        bool isSelected,
        int addressId,
        int customerId,
        String firstName,
        String address,
        String postCode,
        String city,
        String mobile,
        String area,
        String lat,
        String lng,
        String blokNumber,
        String deviceType,
        String landmark}) {
    this._isSelected = isSelected;
    this._addressId = addressId;
    this._customerId = customerId;
    this._firstName = firstName;
    this._address = address;
    this._postCode = postCode;
    this._city = city;
    this._mobile = mobile;
    this._area = area;
    this._lat = lat;
    this._lng = lng;
    this._blokNumber = blokNumber;
    this._deviceType = deviceType;
    this._landmark = landmark;
  }

  bool get isSelected => _isSelected?? false;
  set isSelected(bool value) {
    _isSelected = value;
  }
  int get addressId => _addressId;
  set addressId(int addressId) => _addressId = addressId;
  int get customerId => _customerId;
  set customerId(int customerId) => _customerId = customerId;
  String get firstName => _firstName;
  set firstName(String firstName) => _firstName = firstName;
  String get address => _address;
  set address(String address) => _address = address;
  String get postCode => _postCode;
  set postCode(String postCode) => _postCode = postCode;
  String get city => _city;
  set city(String city) => _city = city;
  String get mobile => _mobile;
  set mobile(String mobile) => _mobile = mobile;
  String get area => _area;
  set area(String area) => _area = area;
  String get lat => _lat;
  set lat(String lat) => _lat = lat;
  String get lng => _lng;
  set lng(String lng) => _lng = lng;
  String get blokNumber => _blokNumber;
  set blokNumber(String blokNumber) => _blokNumber = blokNumber;
  String get deviceType => _deviceType;
  set deviceType(String deviceType) => _deviceType = deviceType;
  String get landmark => _landmark;
  set landmark(String landmark) => _landmark = landmark;

  AddressDetails.fromJson(Map<String, dynamic> json) {
    _addressId = json['addressId'];
    _customerId = json['customerId'];
    _firstName = json['firstName'];
    _address = json['address'];
    _postCode = json['postCode'];
    _city = json['city'];
    _mobile = json['mobile'];
    _area = json['area'];
    _lat = json['lat'] != null ? json['lat'] : '0.0';
    _lng = json['lng'] != null ? json['lng'] : '0.0';
    _blokNumber = json['blokNumber'];
    _deviceType = json['deviceType'];
    _landmark = json['landmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressId'] = this._addressId;
    data['customerId'] = this._customerId;
    data['firstName'] = this._firstName;
    data['address'] = this._address;
    data['postCode'] = this._postCode;
    data['city'] = this._city;
    data['mobile'] = this._mobile;
    data['area'] = this._area;
    data['lat'] = this._lat;
    data['lng'] = this._lng;
    data['blokNumber'] = this._blokNumber;
    data['deviceType'] = this._deviceType;
    data['landmark'] = this._landmark;
    return data;
  }
}

