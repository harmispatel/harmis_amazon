class RegisterMaster {
  int _success;
  String _message;
  RegisterDetails _result;

  RegisterMaster({int success, String message, RegisterDetails result}) {
    this._success = success;
    this._message = message;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  RegisterDetails get result => _result;
  set result(RegisterDetails result) => _result = result;

  RegisterMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'].toString().replaceAll('labels.', ' ');
    _result = json['result'] != null
        ? new RegisterDetails.fromJson(json['result'])
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

class RegisterDetails {
  int _customersId;
  String _firstName;
  String _lastName;
  String _mobilePhone;
  String _gender;
  String _email;
  String _password;
  String _dob;
  String _otp;

  RegisterDetails(
      {int customersId,
      String firstName,
      String lastName,
      String mobilePhone,
      String gender,
      String email,
      String password,
      String dob,
      String otp}) {
    this._customersId = customersId;
    this._firstName = firstName;
    this._lastName = lastName;
    this._mobilePhone = mobilePhone;
    this._gender = gender;
    this._email = email;
    this._password = password;
    this._dob = dob;
    this._otp = otp;
  }

  int get customersId => _customersId;
  set customersId(int customersId) => _customersId = customersId;
  String get firstName => _firstName;
  set firstName(String firstName) => _firstName = firstName;
  String get lastName => _lastName;
  set lastName(String lastName) => _lastName = lastName;
  String get mobilePhone => _mobilePhone;
  set mobilePhone(String mobilePhone) => _mobilePhone = mobilePhone;
  String get gender => _gender;
  set gender(String gender) => _gender = gender;
  String get email => _email;
  set email(String email) => _email = email;
  String get password => _password;
  set password(String password) => _password = password;
  String get dob => _dob;
  set dob(String dob) => _dob = dob;
  String get otp => _otp;
  set otp(String otp) => _otp = otp;

  RegisterDetails.fromJson(Map<String, dynamic> json) {
    _customersId = json['customerId'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _mobilePhone = json['mobilePhone'];
    _gender = json['gender'];
    _email = json['email'];
    _password = json['password'];
    _dob = json['dob'];
    _otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this._customersId;
    data['firstName'] = this._firstName;
    data['lastName'] = this._lastName;
    data['mobilePhone'] = this._mobilePhone;
    data['gender'] = this._gender;
    data['email'] = this._email;
    data['password'] = this._password;
    data['dob'] = this._dob;
    data['otp'] = this._otp;
    return data;
  }
}
