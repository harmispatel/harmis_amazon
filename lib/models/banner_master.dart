class BannerMaster {
  int _success;
  String _message;
  List<BannerDetails> _result;

  BannerMaster({int success, String message, List<BannerDetails> result}) {
    this._success = success;
    this._message = message;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  List<BannerDetails> get result => _result;
  set result(List<BannerDetails> result) => _result = result;

  BannerMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'].toString().replaceAll('labels.', '');
    if (json['result'] != null) {
      _result = new List<BannerDetails>();
      json['result'].forEach((v) {
        _result.add(new BannerDetails.fromJson(v));
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

class BannerDetails {
  int _slidersId;
  String _slidersTitle;
  String _slidersUrl;
  String _slidersImg;
  String _slidersGroup;
  String _slidersHtmlText;
  int _status;
  String _type;

  BannerDetails(
      {int slidersId,
        String slidersTitle,
        String slidersUrl,
        String slidersImg,
        String slidersGroup,
        String slidersHtmlText,
        int status,
        String type}) {
    this._slidersId = slidersId;
    this._slidersTitle = slidersTitle;
    this._slidersUrl = slidersUrl;
    this._slidersImg = slidersImg;
    this._slidersGroup = slidersGroup;
    this._slidersHtmlText = slidersHtmlText;
    this._status = status;
    this._type = type;
  }

  int get slidersId => _slidersId;
  set slidersId(int slidersId) => _slidersId = slidersId;
  String get slidersTitle => _slidersTitle;
  set slidersTitle(String slidersTitle) => _slidersTitle = slidersTitle;
  String get slidersUrl => _slidersUrl;
  set slidersUrl(String slidersUrl) => _slidersUrl = slidersUrl;
  String get slidersImg => _slidersImg;
  set slidersImg(String slidersImg) => _slidersImg = slidersImg;
  String get slidersGroup => _slidersGroup;
  set slidersGroup(String slidersGroup) => _slidersGroup = slidersGroup;
  String get slidersHtmlText => _slidersHtmlText;
  set slidersHtmlText(String slidersHtmlText) =>
      _slidersHtmlText = slidersHtmlText;
  int get status => _status;
  set status(int status) => _status = status;
  String get type => _type;
  set type(String type) => _type = type;

  BannerDetails.fromJson(Map<String, dynamic> json) {
    _slidersId = json['slidersId'];
    _slidersTitle = json['slidersTitle'];
    _slidersUrl = json['slidersUrl'];
    _slidersImg = json['sliders_Img'];
    _slidersGroup = json['slidersGroup'];
    _slidersHtmlText = json['slidersHtmlText'];
    _status = json['status'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slidersId'] = this._slidersId;
    data['slidersTitle'] = this._slidersTitle;
    data['slidersUrl'] = this._slidersUrl;
    data['sliders_Img'] = this._slidersImg;
    data['slidersGroup'] = this._slidersGroup;
    data['slidersHtmlText'] = this._slidersHtmlText;
    data['status'] = this._status;
    data['type'] = this._type;
    return data;
  }
}