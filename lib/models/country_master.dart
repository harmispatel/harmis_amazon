class CountryMaster {
  int _success;
  String _message;
  List<CountryDetails> _result;

  CountryMaster({int success, String message, List<CountryDetails> result}) {
    this._success = success;
    this._message = message;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  List<CountryDetails> get result => _result;
  set result(List<CountryDetails> result) => _result = result;

  CountryMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'].toString().replaceAll('labels.', ' ');
    if (json['result'] != null) {
      _result = new List<CountryDetails>();
      json['result'].forEach((v) {
        _result.add(new CountryDetails.fromJson(v));
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

class CountryDetails {
  int _countryId;
  String _countryName;
  String _countryIsoCode2;
  String _countryIsoCode3;
  int _countyCode;
  String _countryImg;

  CountryDetails(
      {int countryId,
        String countryName,
        String countryIsoCode2,
        String countryIsoCode3,
        int countyCode,
        String countryImg}) {
    this._countryId = countryId;
    this._countryName = countryName;
    this._countryIsoCode2 = countryIsoCode2;
    this._countryIsoCode3 = countryIsoCode3;
    this._countyCode = countyCode;
    this._countryImg = countryImg;
  }

  int get countryId => _countryId;
  set countryId(int countryId) => _countryId = countryId;
  String get countryName => _countryName;
  set countryName(String countryName) => _countryName = countryName;
  String get countryIsoCode2 => _countryIsoCode2;
  set countryIsoCode2(String countryIsoCode2) =>
      _countryIsoCode2 = countryIsoCode2;
  String get countryIsoCode3 => _countryIsoCode3;
  set countryIsoCode3(String countryIsoCode3) =>
      _countryIsoCode3 = countryIsoCode3;
  int get countyCode => _countyCode;
  set countyCode(int countyCode) => _countyCode = countyCode;
  String get countryImg => _countryImg;
  set countryImg(String countryImg) => _countryImg = countryImg;

  CountryDetails.fromJson(Map<String, dynamic> json) {
    _countryId = json['countryId'];
    _countryName = json['countryName'];
    _countryIsoCode2 = json['countryIsoCode2'];
    _countryIsoCode3 = json['countryIsoCode3'];
    _countyCode = json['countryCode'];
    _countryImg = json['countryImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this._countryId;
    data['countryName'] = this._countryName;
    data['countryIsoCode2'] = this._countryIsoCode2;
    data['countryIsoCode3'] = this._countryIsoCode3;
    data['countryCode'] = this._countyCode;
    data['countryImg'] = this._countryImg;
    return data;
  }
}