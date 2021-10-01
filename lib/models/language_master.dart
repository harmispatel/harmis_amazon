class LanguageMaster {
  String _language;
  String _languageCode;
  bool _isSelected;

  LanguageMaster({String language, String languageCode, bool isSelected}) {
    this._language = language;
    this._languageCode = languageCode;
    this._isSelected = isSelected;
  }

  bool get isSelected => _isSelected?? false;

  set isSelected(bool value) {
    _isSelected = value;
  }

  String get language => _language;

  set language(String value) {
    _language = value;
  }

  String get languageCode => _languageCode;

  set languageCode(String value) {
    _languageCode = value;
  }
}