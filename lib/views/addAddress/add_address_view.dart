import 'package:big_mart/database/app_preferences.dart';
import 'package:big_mart/generated/i18n.dart';
import 'package:big_mart/models/address.dart';
import 'package:big_mart/models/country_master.dart';
import 'package:big_mart/utils/common_colors.dart';
import 'package:big_mart/utils/common_utils.dart';
import 'package:big_mart/utils/constant.dart';
import 'package:big_mart/utils/text_style.dart';
import 'package:big_mart/views/filter_dialog/filter_category_item.dart';
import 'package:big_mart/views/register/choose_country.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
//import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'add_address_view_model.dart';

class AddAddressView extends StatefulWidget {
  AddressDetails addressDetails;

  AddAddressView({this.addressDetails});

  @override
  _AddAddressViewState createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  AddAddressViewModel mViewModel;
  TextEditingController mReceiversNameController = new TextEditingController();
  TextEditingController mMobileController = new TextEditingController();
  TextEditingController mBuildingController = new TextEditingController();
  final globalKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<AddAddressViewModel>(context, listen: false);
      mViewModel.attachContext(context);
      mViewModel.initCountryList();

      if (widget.addressDetails != null) {
        mReceiversNameController.text = widget.addressDetails?.firstName ?? "";
        mMobileController.text = widget.addressDetails?.mobile ?? "";
        mViewModel.mAddressController.text = widget.addressDetails?.address ?? "";
        mBuildingController.text = widget.addressDetails?.blokNumber ?? "";
        mViewModel.city = widget.addressDetails?.city ?? "";
        mViewModel.selectedLatLng =
            new LatLng(double.parse(widget.addressDetails.lat), double.parse(widget.addressDetails.lng));
        mViewModel.animateCameraToLocation(mViewModel.currentLocation.latitude,
            mViewModel.currentLocation.longitude);
      } else {
        mViewModel.locationPermission(onAddress: (String address) {
          mViewModel.mAddressController.text = address.toString();
          mViewModel.setMarker(address.toString());
          mViewModel.notifyListeners();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<AddAddressViewModel>(context);

    final topIcon = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 30,
          height: 2,
          color: CommonColors.dark_6060,
          margin: EdgeInsets.only(top: 5, bottom: 5),
        )
      ],
    );

    final layoutAddAdress = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context,true);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 20, right: 20),
                child: Text(
                  S.of(context).addAddress,
                  style: CommonStyle.getAppFont(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: CommonColors.dark_6060),
                ),
              ),
            ],
          ),
          Container(
            color: CommonColors.color_dcdcdc,
            height: 1,
          )
        ],
      ),
    );

    final tvInfo = Container(
      padding: const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
      child: Text(
        S.of(context).youCanAddNewAddress,
        style: CommonStyle.getAppFont(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: CommonColors.color_515c6f),
      ),
    );

    final countryDropDown = mViewModel.selectedCountry != null
        ? InkWell(
            onTap: () {
              _openCountryCodePickerDialog();
            },
            child: Container(
              height: 45,
              width: 60,
              margin: EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    margin: EdgeInsets.only(right: 2),
                    child: Image.network(
                        mViewModel.selectedCountry.countryImg.toString()),
                  ),
                  Text(
                    "+" + mViewModel.selectedCountry.countyCode.toString(),
                    style: CommonStyle.getAppFont(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal),
                  ),
                ],
              ),
            ),
          )
        : Container();

    final layoutMobileNumber = Container(
      height: 45,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20, right: 20),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey, width: 1))),
      child: Row(
        children: [
          countryDropDown,
          Flexible(
              child: setMobileTextField(
                  S.of(context).mobileNumber, mMobileController, true)),
        ],
      ),
    );

    final layoutBottom = Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
      child: InkWell(
        onTap: ()  {
          if (isValid()) {
             mViewModel.addAddress(
              addressId: widget.addressDetails != null
                  ? widget.addressDetails.addressId.toString()
                  : null,
              firstName: mReceiversNameController.text,
              mobile: "+918780903381",
              address: mViewModel.mAddressController.text,
              blockNumber: mBuildingController.text,
            );

          }
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Center(
            child: Text(
              widget.addressDetails == null
                  ? S.of(context).addNewAddress.toUpperCase()
                  : S.of(context).editAddress.toUpperCase(),
              style: CommonStyle.getAppFont(
                  color: CommonColors.white,
                  fontSize: 13,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );

    /*return Scaffold(
      key: globalKey,
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 12),
                child: Column(
                  children: [
                    topIcon,
                    layoutAddAdress,
                    Expanded(
                        *//*      child: Text(
                      'here Google map',
                      style: TextStyle(fontSize: 20),
                    )*//*
                        child: GoogleMap(
                            mapType: MapType.normal,
                            compassEnabled: true,
                            myLocationEnabled: true,
                            tiltGesturesEnabled: true,
                            initialCameraPosition: mViewModel.initialCamera,
                            onTap: (latlng) {
                              mViewModel.selectedLatLng = latlng;
                              mViewModel.getAddressFromLatlong(
                                  lat: latlng.latitude,
                                  long: latlng.longitude,
                                  onAddress: (String address) {
                                    mViewModel.setMarker(address);
                                    mViewModel.mAddressController.text = address;
                                    mViewModel.notifyListeners();
                                  });
                            },
                            onCameraIdle: () {
                              debugPrint("camera idle");
                            },
                            onCameraMove: (position) {},
                            myLocationButtonEnabled: false,
                            markers: Set<Marker>.of(mViewModel.markers.values),
                            onMapCreated:
                                (GoogleMapController googleMapController) {
                              mViewModel.mapController = googleMapController;
                              if (!mViewModel.controller.isCompleted)
                                mViewModel.controller
                                    .complete(googleMapController);
                            },
                            gestureRecognizers:
                                <Factory<OneSequenceGestureRecognizer>>[
                              new Factory<OneSequenceGestureRecognizer>(
                                () => new EagerGestureRecognizer(),
                              ),
                            ].toSet()))
                  ],
                ),
              ),
            ),
            Column(
              children: [
                setTextField(S.of(context).receiversName,
                    mReceiversNameController, true),
                layoutMobileNumber,
                // setTextField(S.of(context).city, mCityController, true),
                InkWell(
                    onTap: () {
                      mViewModel.OpenPlaceAutoComplete(
                          onSuccess: (String address) {
                        mViewModel.mAddressController.text = address;
                      });
                    },
                    child: setTextField(
                        S.of(context).address, mViewModel.mAddressController, false)),
                setTextField(
                    S.of(context).addressBuilding, mBuildingController, true),
                // setTextField(S.of(context).landmarkOptional, mLandmarkController, true),
                layoutBottom,
              ],
            )
          ],
        ),
      ),
    );*/

   /* return Scaffold(
      key: globalKey,
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 12),
                child: Column(
                  children: [
                    topIcon,
                    layoutAddAdress,
                    Expanded(
                      *//*      child: Text(
                      'here Google map',
                      style: TextStyle(fontSize: 20),
                    )*//*
                        child: GoogleMap(
                            mapType: MapType.normal,
                            compassEnabled: true,
                            myLocationEnabled: true,
                            tiltGesturesEnabled: true,
                            initialCameraPosition: mViewModel.initialCamera,
                            onTap: (latlng) {
                              mViewModel.selectedLatLng = latlng;
                              mViewModel.getAddressFromLatlong(
                                  lat: latlng.latitude,
                                  long: latlng.longitude,
                                  onAddress: (String address) {
                                    mViewModel.setMarker(address);
                                    mViewModel.mAddressController.text = address;
                                    mViewModel.notifyListeners();
                                  });
                            },
                            onCameraIdle: () {
                              debugPrint("camera idle");
                            },
                            onCameraMove: (position) {},
                            myLocationButtonEnabled: false,
                            markers: Set<Marker>.of(mViewModel.markers.values),
                            onMapCreated:
                                (GoogleMapController googleMapController) {
                              mViewModel.mapController = googleMapController;
                              if (!mViewModel.controller.isCompleted)
                                mViewModel.controller
                                    .complete(googleMapController);
                            },
                            gestureRecognizers:
                            <Factory<OneSequenceGestureRecognizer>>[
                              new Factory<OneSequenceGestureRecognizer>(
                                    () => new EagerGestureRecognizer(),
                              ),
                            ].toSet()))
                  ],
                ),
              ),
            ),
            Column(
              children: [
                setTextField(S.of(context).receiversName,
                    mReceiversNameController, true),
                layoutMobileNumber,
                // setTextField(S.of(context).city, mCityController, true),
                InkWell(
                    onTap: () {
                      mViewModel.OpenPlaceAutoComplete(
                          onSuccess: (String address) {
                            mViewModel.mAddressController.text = address;
                          });
                    },
                    child: setTextField(
                        S.of(context).address, mViewModel.mAddressController, false)),
                setTextField(
                    S.of(context).addressBuilding, mBuildingController, true),
                // setTextField(S.of(context).landmarkOptional, mLandmarkController, true),
                layoutBottom,
              ],
            )
          ],
        ),
      ),
    );*/

    return Scaffold(
      key: globalKey,
      body:Container(
        margin: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 12),
                child: Column(
                  children: [
                    topIcon,
                    layoutAddAdress,
                    Expanded(
                      /*      child: Text(
                      'here Google map',
                      style: TextStyle(fontSize: 20),
                    )*/
                        child: GoogleMap(
                            mapType: MapType.normal,
                            compassEnabled: true,
                            myLocationEnabled: true,
                            tiltGesturesEnabled: true,
                            initialCameraPosition: mViewModel.initialCamera,
                            onTap: (latlng) {
                              mViewModel.selectedLatLng = latlng;
                              mViewModel.getAddressFromLatlong(
                                  lat: latlng.latitude,
                                  long: latlng.longitude,
                                  onAddress: (String address) {
                                    mViewModel.setMarker(address);
                                    mViewModel.mAddressController.text = address;
                                    mViewModel.notifyListeners();
                                  });
                            },
                            onCameraIdle: () {
                              debugPrint("camera idle");
                            },
                            onCameraMove: (position) {},
                            myLocationButtonEnabled: false,
                            markers: Set<Marker>.of(mViewModel.markers.values),
                            onMapCreated:
                                (GoogleMapController googleMapController) {
                              mViewModel.mapController = googleMapController;
                              if (!mViewModel.controller.isCompleted)
                                mViewModel.controller
                                    .complete(googleMapController);
                            },
                            gestureRecognizers:
                            <Factory<OneSequenceGestureRecognizer>>[
                              new Factory<OneSequenceGestureRecognizer>(
                                    () => new EagerGestureRecognizer(),
                              ),
                            ].toSet()))
                  ],
                ),
              ),
            ),
            Column(
              children: [
                setTextField(S.of(context).receiversName,
                    mReceiversNameController, true),
                layoutMobileNumber,
                // setTextField(S.of(context).city, mCityController, true),
                InkWell(
                    onTap: () {
                      mViewModel.OpenPlaceAutoComplete(
                          onSuccess: (String address) {
                            mViewModel.mAddressController.text = address;
                          });
                    },
                    child: setTextField(
                        S.of(context).address, mViewModel.mAddressController, false)),
                setTextField(
                    S.of(context).addressBuilding, mBuildingController, true),
                // setTextField(S.of(context).landmarkOptional, mLandmarkController, true),
                layoutBottom,
              ],
            )
          ],
        ),
      )
    );
  }

  Widget setTextField(String placeholder, controller, bool enable) {
    return Container(
      height: 45,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20, right: 20),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey, width: 1))),
      child: TextField(
        enabled: enable,
        controller: controller,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: CommonStyle.getAppFont(
              color: CommonColors.color_96979d,
              fontWeight: FontWeight.w400,
              fontSize: 16.0),
          contentPadding: EdgeInsets.only(left: 10, right: 10),
          border: InputBorder.none,
        ),
        style: CommonStyle.getAppFont(
            fontWeight: FontWeight.w400,
            fontSize: 16.0),
        maxLines: 1,
        autocorrect: false,
      ),
    );
  }

  Widget setMobileTextField(String placeholder, controller, bool enable) {
    return TextField(
      enabled: enable,
      controller: controller,
      decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: CommonStyle.getAppFont(
              color: CommonColors.color_96979d,
              fontWeight: FontWeight.w400,
              fontSize: 16.0),
          contentPadding: EdgeInsets.only(left: 10, right: 10),
          border: InputBorder.none,
          counterText: ""),
      style: CommonStyle.getAppFont(
          fontWeight: FontWeight.w400,
          fontSize: 16.0),
      maxLines: 1,
      maxLength: 10,
      autocorrect: false,
      keyboardType: TextInputType.number,
    );
  }

  void _openCountryCodePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => ChooseCountryDialog(
        title: S.of(context).countryCode,
        countryList: mViewModel.countryList,
        onCountrySelected: (CountryDetails country) {
          Navigator.pop(context);
          mViewModel.selectedCountry = country;
          mViewModel.notifyListeners();
        },
      ),
    );
  }

  bool isValid() {
    if (mReceiversNameController.text.isEmpty) {
      CommonUtils.showSnackBar(S.of(context).enterReceiverName, globalKey);
      return false;
    } /*else if (mMobileController.text.isEmpty) {
      CommonUtils.showSnackBar(S.of(context).enterMobileNumber, globalKey);
      return false;
    }*/
    /* else if (mCityController.text.isEmpty) {
      CommonUtils.showSnackBar(S.of(context).enterCity, globalKey);
      return false;
    } else if (mAreaController.text.isEmpty) {
      CommonUtils.showSnackBar(S.of(context).enterArea, globalKey);
      return false;
    }*/
    else if (mViewModel.mAddressController.text.isEmpty) {
      CommonUtils.showSnackBar(S.of(context).enterAddress, globalKey);
      return false;
    } else if (mBuildingController.text.isEmpty) {
      CommonUtils.showSnackBar(S.of(context).enterBlockNumber, globalKey);
      return false;
    } else {
      return true;
    }
  }
}
