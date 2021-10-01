import 'dart:async';
import 'dart:convert';
import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/add_address.dart';
import 'package:big_mart/models/brand_master.dart';
import 'package:big_mart/models/category.dart';
import 'package:big_mart/models/country_master.dart';
import 'package:big_mart/models/google_address.dart';
import 'package:big_mart/models/message.dart';
import 'package:big_mart/models/register_master.dart';
import 'package:big_mart/models/user.dart';
import 'package:big_mart/services/base_services.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:google_maps_webservice/places.dart' as pred;

class AddAddressViewModel with ChangeNotifier {
  BuildContext mContext;
  Services _services = new Services();
  AppPreferences appPreferences = new AppPreferences();
  String languageCode;
  LoginDetails loginDetails;

  CountryDetails selectedCountry;
  List<CountryDetails> countryList = new List();
  List<DropdownMenuItem<CountryDetails>> countryDropdownMenuItems;
  MessageMaster master;
  Completer<GoogleMapController> controller = Completer();
  GoogleMapController mapController;
  LocationData currentLocation;
  LatLng selectedLatLng;
  static double _zoom = 15;
  CameraPosition initialCamera = CameraPosition(
    target: LatLng(23.0225, 72.5714),
    zoom: _zoom,
  );
  String city;
  TextEditingController mAddressController = new TextEditingController();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  pred.GoogleMapsPlaces _places =
      pred.GoogleMapsPlaces(apiKey: AppConstants.googleApiKey);

  void attachContext(BuildContext context) {
    mContext = context;
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
          print(currentLocation);
          selectedLatLng =
              new LatLng(currentLocation.latitude, currentLocation.longitude);
          animateCameraToLocation(
              currentLocation.latitude, currentLocation.longitude);
          getAddressFromLatlong(
              lat: currentLocation.latitude,
              long: currentLocation.longitude,
              onAddress: onAddress);
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

  void animateCameraToLocation(double lat, double lng) async {
    initialCamera = CameraPosition(
      target: LatLng(lat, lng),
      zoom: _zoom,
    );
    //final GoogleMapController controller = await this.controller.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(initialCamera));
    notifyListeners();
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
          CommonUtils.showToastMessage("");
        });

    if (address != null) {
      String fetchedAddress = address.results[0].formattedAddress;
      city = address.results[0].addressComponents
          .firstWhere((entry) => entry.types.contains('locality'))
          .longName;
      onAddress(fetchedAddress);
      //setMarker(fetchedAddress);
    }

    notifyListeners();
  }

  Future OpenPlaceAutoComplete({Function onSuccess}) async {
    pred.Prediction p = await PlacesAutocomplete.show(
      context: mContext,
      apiKey: AppConstants.googleApiKey,
      mode: Mode.overlay,
      language: "en",
      //components: [new Component(Component.country, "IRQ")]
    );
    //   "";
    if (p != null) {
      pred.PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;
      print(lat.toString() + "//" + lng.toString());
      //  onAddress(detail.result.formattedAddress);
      String fetchedAddress = detail.result.formattedAddress;
      city = detail.result.addressComponents
          .firstWhere((entry) => entry.types.contains('locality'))
          .longName;
      selectedLatLng = new LatLng(lat, lng);
      onSuccess(fetchedAddress);
      setMarker(fetchedAddress);
      animateCameraToLocation(
          selectedLatLng.latitude, selectedLatLng.longitude);
    } else {
      print("P received null");
    }
  }

  void setMarker(String address) {
    MarkerId markerId = new MarkerId("111");
    Marker mMarker = new Marker(
        markerId: markerId,
        icon: BitmapDescriptor.defaultMarker,
        position: selectedLatLng,
        infoWindow: InfoWindow(title: address),
        visible: true);
    markers[markerId] = mMarker;
    notifyListeners();
  }

  void initCountryList() async {
    if (countryList.length == 0) {
      countryList.clear();
      notifyListeners();

      CommonUtils.showProgressDialog(mContext);
      languageCode = await appPreferences.getLanguageCode();
      print("lancode:"+languageCode.toString());
      CountryMaster master = await _services.getCountryList(
          languageCode: languageCode,
          onStartLoading: () {},
          onStopLoading: () {},
          onNoInternet: () {
            CommonUtils.showToastMessage(S.of(mContext).noInternet);
          });
      if (master != null && master.result != null && master.result.length > 0) {
        countryList.addAll(master.result);
        countryDropdownMenuItems = buildCountryDropdownMenuItems(countryList);
        selectedCountry = countryDropdownMenuItems[0].value;
      }
      CommonUtils.hideProgressDialog(mContext);
      notifyListeners();
    }
  }

  List<DropdownMenuItem<CountryDetails>> buildCountryDropdownMenuItems(
      List arrayList) {
    List<DropdownMenuItem<CountryDetails>> items = List();
    for (CountryDetails object in arrayList) {
      items.add(
        DropdownMenuItem(
          value: object,
          child: Padding(
            padding: const EdgeInsets.only(left: 1),
            child: Row(
              children: [
                Container(
                  height: 15,
                  width: 15,
                  margin: EdgeInsets.only(right: 2),
                  child: Image.network(object.countryImg.toString()),
                ),
                Text("+91"
                  /*"+" + object.countyCode.toString()*/,
                  style: CommonStyle.getAppFont(
                      color: CommonColors.primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return items;
  }

  onChangeCountryDropdownItem(CountryDetails country) {
    this.selectedCountry = country;
    notifyListeners();
  }

  Future<void> addAddress({
    String addressId,
    String firstName,
    String address,
    String mobile,
    String blockNumber,
  }) async {
    languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    MessageMaster master = await _services.addAddress(
        languageCode: languageCode.toString(),
        addressId: addressId,
        customersId: loginDetails.customerId.toString(),
        firstName: firstName,
        city: city,
        address: address,
        mobile: mobile,
        latitude: selectedLatLng.latitude.toString(),
        longitude: selectedLatLng.longitude.toString(),
        blockNumber: blockNumber,
        onStartLoading: () {
          CommonUtils.showProgressDialog(mContext);
        },
        onStopLoading: () {
          CommonUtils.hideProgressDialog(mContext);
        },
        onNoInternet: () {
          CommonUtils.showToastMessage(S.of(mContext).noInternet);
        });

    if (master != null) {
      if (master.success == 1) {
        CommonUtils.showGreenToastMessage(master.message.toString());
        Navigator.pop(mContext,mAddressController.text);
      } else {
        CommonUtils.showRedToastMessage(master.message.toString());
      }
    }
    notifyListeners();
  }
}
