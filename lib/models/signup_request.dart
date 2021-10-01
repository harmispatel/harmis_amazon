class SignUpRequest {
  String _firstName;
  String _lastName;
  String _mobileNumber;
  String _password;
  String _gender;
  String _email;
  String _dob;
  String _countryId;
  String _deviceId;
  String _phoneCode;

  String get phoneCode => _phoneCode;

  set phoneCode(String value) {
    _phoneCode = value;
  }

  String get firstName => _firstName;

  set firstName(String value) {
    _firstName = value;
  }

  String get lastName => _lastName;

  String get deviceId => _deviceId;

  set deviceId(String value) {
    _deviceId = value;
  }

  String get countryId => _countryId;

  set countryId(String value) {
    _countryId = value;
  }

  String get dob => _dob;

  set dob(String value) {
    _dob = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get gender => _gender;

  set gender(String value) {
    _gender = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get mobileNumber => _mobileNumber;

  set mobileNumber(String value) {
    _mobileNumber = value;
  }

  set lastName(String value) {
    _lastName = value;
  }
}
