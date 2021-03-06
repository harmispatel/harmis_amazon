


import 'dart:convert';

import 'package:big_mart/views/filter_dialog/filter_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:big_mart/models/user.dart';

class AppPreferences{


  //------------------------------------------------------------- Preference Constants ------------------------------------------------------------

  // Constants for Preference-Value's data-type
  static const String PREF_TYPE_BOOL = "BOOL";
  static const String PREF_TYPE_INTEGER = "INTEGER";
  static const String PREF_TYPE_DOUBLE = "DOUBLE";
  static const String PREF_TYPE_STRING = "STRING";
  static const String KEY_LOGIN_DETAILS = "KEY_LOGIN_DETAILS";
  static const String KEY_LANGUAGE_CODE = "KEY_LANGUAGE_CODE";
  static const String KEY_DEVICE_TOKEN = "KEY_DEVICE_TOKEN";
  static const String KEY_CHAT_ADMIN_ID = "KEY_CHAT_ADMIN_ID";
  static const String KEY_NOTIFICATION_ON_OFF = "KEY_NOTIFICATION_ON_OFF";
  static const String KEY_LATITUDE = "KEY_LATITUDE";
  static const String KEY_LONGITUDE = "KEY_LONGITUDE";
  static const String KEY_APP_FIRST_LOADING = "KEY_APP_FIRST_LOADING";
  static const String KEY_FILTER = "KEY_FILTER";


  // Constants for Preference-Name
  static const String PREF_IS_LOGGED_IN = "IS_LOGGED_IN";

  //-------------------------------------------------------------------- Variables -------------------------------------------------------------------
  // Future variable to check SharedPreference Instance is ready
  // This is actually a hack. As constructor is not allowed to have 'async' we cant 'await' for future value
  // SharedPreference.getInstance() returns Future<SharedPreference> object and we want to assign its value to our private _preference variable
  // In case if we don't 'await' for SharedPreference.getInstance() method, and in mean time if we access preferences using _preference variable we will get
  // NullPointerException for _preference variable, as it isn't yet initialized.
  // We need to 'await' _isPreferenceReady value for only once when preferences are first time requested in application lifecycle because in further
  // future requests, preference instance is already ready as we are using Singleton-Instance.
  Future _isPreferenceInstanceReady;

  // Private variable for SharedPreferences
  SharedPreferences _preferences;


  /// ------------------------------------------------------------
  /// Method that returns the user decision on sorting order
  /// ------------------------------------------------------------
  Future<LoginDetails> getLoginDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String login_details =  prefs.getString(KEY_LOGIN_DETAILS) ?? null;
    try {
      return LoginDetails.fromJson(json.decode(login_details));
    } catch (e){
      return null;
    }
  }

  /// ----------------------------------------------------------
  /// Method that saves the user decision on sorting order
  /// ----------------------------------------------------------
  Future<bool> setLoginDetails(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(KEY_LOGIN_DETAILS, value);
  }

  /// ------------------------------------------------------------
  /// Method that returns the user decision on sorting order
  /// ------------------------------------------------------------
  Future<String> getLanguageCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_LANGUAGE_CODE) ?? null;
  }

  /// ----------------------------------------------------------
  /// Method that saves the user decision on sorting order
  /// ----------------------------------------------------------
  Future<bool> setLanguageCode(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(KEY_LANGUAGE_CODE, value);
  }

  /// ------------------------------------------------------------
  /// Method that returns the user decision on sorting order
  /// ------------------------------------------------------------
  Future<String> getDeviceToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_DEVICE_TOKEN) ?? '111';
  }

  /// ----------------------------------------------------------
  /// Method that saves the user decision on sorting order
  /// ----------------------------------------------------------
  Future<bool> setDeviceToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(KEY_DEVICE_TOKEN, value);
  }

  Future<String> getFirebaseChatId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_CHAT_ADMIN_ID) ?? '';
  }

  Future<bool> setFirebaseChatId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(KEY_CHAT_ADMIN_ID, value);
  }

  Future<int> getNotificationSwitch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(KEY_NOTIFICATION_ON_OFF) ?? 0;
  }

  Future<bool> setNotificationSwitch(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(KEY_NOTIFICATION_ON_OFF, value);
  }

  Future<double> getLatitude() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(KEY_LATITUDE) ?? 0;
  }

  Future<bool> setLatitude(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(KEY_LATITUDE, value);
  }

  Future<double> getLongitude() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(KEY_LONGITUDE) ?? 0;
  }

  Future<bool> setLongitude(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(KEY_LONGITUDE, value);
  }

  Future<bool> setAppFirstLoading(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(KEY_APP_FIRST_LOADING, value);
  }

  Future<bool> getAppFirstLoading() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KEY_APP_FIRST_LOADING) ?? true;
  }

  // For filters
  Future<FilterModel> getFilter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String filters = prefs.getString(KEY_FILTER) ?? null;
    try {
      return FilterModel.fromJson(json.decode(filters));
    } catch (e) {
      return null;
    }
  }

  Future<bool> setFilter(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(KEY_FILTER, value);
  }


  //-------------------------------------------------------------------- Singleton ----------------------------------------------------------------------
  // Final static instance of class initialized by private constructor
  static final AppPreferences _instance = AppPreferences._internal();
  // Factory Constructor
  factory AppPreferences()=> _instance;

  /// AppPreference Private Internal Constructor -> AppPreference
  /// @param->_
  /// @usage-> Initialize SharedPreference object and notify when operation is complete to future variable.
  AppPreferences._internal(){
    _isPreferenceInstanceReady = SharedPreferences.getInstance().then((preferences)=> _preferences = preferences);
  }

  //------------------------------------------------------- Getter Methods -----------------------------------------------------------
  // GETTER for isPreferenceReady future
  Future get isPreferenceReady => _isPreferenceInstanceReady;

  //--------------------------------------------------- Public Preference Methods -------------------------------------------------------------

  /// Set Logged-In Method -> void
  /// @param -> @required isLoggedIn -> bool
  /// @usage -> Set value of IS_LOGGED_IN in preferences
  void setLoggedIn({@required bool isLoggedIn}) => _setPreference(prefName: PREF_IS_LOGGED_IN, prefValue: isLoggedIn, prefType: PREF_TYPE_BOOL);

  /// Get Logged-In Method -> Future<bool>
  /// @param -> _
  /// @usage -> Get value of IS_LOGGED_IN from preferences
  Future<bool> getLoggedIn() async => await _getPreference(prefName: PREF_IS_LOGGED_IN) ?? false;// Check value for NULL. If NULL provide default value as FALSE.


  //--------------------------------------------------- Private Preference Methods ----------------------------------------------------
  /// Set Preference Method -> void
  /// @param -> @required prefName -> String
  ///        -> @required prefValue -> dynamic
  ///        -> @required prefType -> String
  /// @usage -> This is a generalized method to set preferences with required Preference-Name(Key) with Preference-Value(Value) and Preference-Value's data-type.
  void _setPreference ({@required String prefName,@required dynamic prefValue,@required String prefType}){
    // Make switch for Preference Type i.e. Preference-Value's data-type
    switch(prefType){
    // prefType is bool
      case PREF_TYPE_BOOL:{
        _preferences.setBool(prefName, prefValue);
        break;
      }
    // prefType is int
      case PREF_TYPE_INTEGER:{
        _preferences.setInt(prefName, prefValue);
        break;
      }
    // prefType is double
      case PREF_TYPE_DOUBLE:{
        _preferences.setDouble(prefName, prefValue);
        break;
      }
    // prefType is String
      case PREF_TYPE_STRING:{
        _preferences.setString(prefName, prefValue);
        break;
      }
    }

  }

  /// Get Preference Method -> Future<dynamic>
  /// @param -> @required prefName -> String
  /// @usage -> Returns Preference-Value for given Preference-Name
  Future<dynamic> _getPreference({@required prefName}) async => _preferences.get(prefName);

}
