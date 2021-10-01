class AddAdderessMaster {
  int _success;
  String _message;
  AddAddressDetails _result;

  AddAdderessMaster({int success, String message, AddAddressDetails result}) {
    this._success = success;
    this._message = message;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  AddAddressDetails get result => _result;
  set result(AddAddressDetails result) => _result = result;

  AddAdderessMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'].toString().replaceAll('labels.', ' ');
    _result =
    json['result'] != null ? new AddAddressDetails.fromJson(json['result']) : null;
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

class AddAddressDetails {
  int _addressId;
  int _customersId;
  String _firstName;
  String _address;
  String _postCode;
  String _city;
  String _mobile;
  String _area;
  String _landmark;

  AddAddressDetails(
      {int addressId,
        int customersId,
        String firstName,
        String address,
        String postCode,
        String city,
        String mobile,
        String area,
        String landmark}) {
    this._addressId = addressId;
    this._customersId = customersId;
    this._firstName = firstName;
    this._address = address;
    this._postCode = postCode;
    this._city = city;
    this._mobile = mobile;
    this._area = area;
    this._landmark = landmark;
  }

  int get addressId => _addressId;
  set addressId(int addressId) => _addressId = addressId;
  int get customersId => _customersId;
  set customersId(int customersId) => _customersId = customersId;
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
  String get landmark => _landmark;
  set landmark(String landmark) => _landmark = landmark;

  AddAddressDetails.fromJson(Map<String, dynamic> json) {
    _addressId = json['addressId'];
    _customersId = json['customersId'];
    _firstName = json['firstName'];
    _address = json['address'];
    _postCode = json['postCode'];
    _city = json['city'];
    _mobile = json['mobile'];
    _area = json['area'];
    _landmark = json['landmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressId'] = this._addressId;
    data['customersId'] = this._customersId;
    data['firstName'] = this._firstName;
    data['address'] = this._address;
    data['postCode'] = this._postCode;
    data['city'] = this._city;
    data['mobile'] = this._mobile;
    data['area'] = this._area;
    data['landmark'] = this._landmark;
    return data;
  }
}
