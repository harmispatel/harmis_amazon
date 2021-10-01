import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/models/google_address.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

class CurrentLocationHeaderViewModel with ChangeNotifier {
  BuildContext mContext;
  LocationData currentLocation;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode;
  LoginDetails loginDetails;

  void attachContext(BuildContext context) {
    this.mContext = context;
  }

  void locationPermission({Function onAddress}) async {
    print("Location permission invoked.");
    Location _locationService = new Location();
    PermissionStatus _permission;
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.high, interval: 1000);
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        if (_permission == PermissionStatus.granted) {
          //CommonUtils.showProgressDialog(context);
          currentLocation = await _locationService.getLocation();
          // currentLocation = LocationData.fromMap({"latitude": 23.0225, "longitude": 72.5714});
          getAddressFromLatlong(
              lat: currentLocation.latitude,
              long: currentLocation.longitude, onAddress: onAddress);
          //CommonUtils.hideProgressDialog(context);
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        if (serviceStatusResult &&
            await ph.Permission.storage.request().isGranted) {
          locationPermission();
        }
      }
    } catch (e) {
      //CommonUtils.hideProgressDialog(context);
      print("Location error: " + e.toString());
    }
  }

  Future<void> getAddressFromLatlong(
      {double lat, double long, Function onAddress}) async {
    GoogleAddressMaster address = await _services.getAddressFromLatlong(
        lat: lat,
        long: long,
        onStartLoading: () {
          // CommonUtils.showProgressDialog(mContext);
        },
        onStopLoading: () {
          // CommonUtils.hideProgressDialog(mContext);
        },
        onNoInternet: () {

        });

    if (address != null) {
      String fetchedAddress = address.results[0].formattedAddress;
      onAddress(fetchedAddress);
    }
    notifyListeners();
  }
}