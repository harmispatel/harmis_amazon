class LoginMaster {
  int _success;
  String _message;
  LoginDetails _result;

  LoginMaster({int success, String message, LoginDetails result}) {
    this._success = success;
    this._message = message;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  LoginDetails get result => _result;
  set result(LoginDetails result) => _result = result;

  LoginMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'].toString().replaceAll('labels.', ' ');
    _result = json['result'] != null
        ? new LoginDetails.fromJson(json['result'])
        : null;
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

class LoginDetails {
  int _customerId;
  String _gender;
  String _firstName;
  String _lastName;
  String _dob;
  String _email;
  String _userName;
  String _mobile;
  int _countryCode;
  String _countryId;
  String _defaultAddressId;
  int _isActive;
  String _image;

  LoginDetails(
      {int customerId,
      String gender,
      String firstName,
      String lastName,
      String dob,
      String email,
      String userName,
      String mobile,
      int countryCode,
      String countryId,
      String defaultAddressId,
      int isActive,
      String image}) {
    this._customerId = customerId;
    this._gender = gender;
    this._firstName = firstName;
    this._lastName = lastName;
    this._dob = dob;
    this._email = email;
    this._userName = userName;
    this._mobile = mobile;
    this._countryCode = countryCode;
    this._countryId = countryId;
    this._defaultAddressId = defaultAddressId;
    this._isActive = isActive;
    this._image = image;
  }

  int get customerId => _customerId;
  set customerId(int customerId) => _customerId = customerId;
  String get gender => _gender;
  set gender(String gender) => _gender = gender;
  String get firstName => _firstName;
  set firstName(String firstName) => _firstName = firstName;
  String get lastName => _lastName;
  set lastName(String lastName) => _lastName = lastName;
  String get dob => _dob;
  set dob(String dob) => _dob = dob;
  String get email => _email;
  set email(String email) => _email = email;
  String get userName => _userName;
  set userName(String userName) => _userName = userName;
  String get mobile => _mobile;
  set mobile(String mobile) => _mobile = mobile;
  int get countryCode => _countryCode;
  set countryCode(int countryCode) => _countryCode = countryCode;

  String get countryId => _countryId;

  set countryId(String value) {
    _countryId = value;
  }

  String get defaultAddressId => _defaultAddressId;
  set defaultAddressId(String defaultAddressId) =>
      _defaultAddressId = defaultAddressId;
  int get isActive => _isActive;
  set isActive(int isActive) => _isActive = isActive;
  String get image => _image;
  set image(String image) => _image = image;

  LoginDetails.fromJson(Map<String, dynamic> json) {
    _customerId = json['customerId'];
    _gender = json['gender'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _dob = json['dob'];
    _email = json['email'];
    _userName = json['userName'];
    _mobile = json['mobile'];
    _countryCode = json['countryCode'];
    _countryId = json['countryId'].toString();
    _defaultAddressId = json['defaultAddressId'];
    _isActive = json['isActive'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this._customerId;
    data['gender'] = this._gender;
    data['firstName'] = this._firstName;
    data['lastName'] = this._lastName;
    data['dob'] = this._dob;
    data['email'] = this._email;
    data['userName'] = this._userName;
    data['mobile'] = this._mobile;
    data['countryCode'] = this._countryCode;
    data['countryId'] = this._countryId;
    data['defaultAddressId'] = this._defaultAddressId;
    data['isActive'] = this._isActive;
    data['image'] = this._image;
    return data;
  }
}
