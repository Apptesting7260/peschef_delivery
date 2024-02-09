import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/models/restroTrackModel.dart';
import 'package:peschef_delivery/repository/repository.dart';

import 'package:shared_preferences/shared_preferences.dart';

class RestroTrackController extends GetxController {
  final _api = Repository();

  var location = "".obs;
  // ================Loction start  =================

  var currentAddress = "".obs;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services'));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        SnackBar(content: Text('Location permissions are denied'));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.'));
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      print("position ${_currentPosition}");
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    print("eveydveyvey ${position}");
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      // setState(() {
      //   _currentAddress =
      //       '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      // });
      print("eveydveyvrgrgrgvrey");
      currentAddress.value =
          '${place.street},${place.subLocality}, ${place.thoroughfare}, ${place.locality}';
      location.value = currentAddress.toString();

      print("lllllllllllllllllll");
      print(place);
      print("jjjjkk ${currentAddress}");
      print("asdfg ${location.value}");
    }).catchError((e) {
      debugPrint("rugrughrughweuh${e}");
    });
  }

  // =============== end ===========================

  final rxRequestStatus = Status.COMPLETED.obs;
  final restroTrackData = RestroTrackModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void RestroTrackSet(RestroTrackModel _value) =>
      restroTrackData.value = _value;
  void setError(String _value) => error.value = _value;

  RestroTrackApi() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString('token') ?? "";
    setRxRequestStatus(Status.LOADING);
    _api.RestroTrackApi(token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      RestroTrackSet(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  Future<void> refreshApi() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString('token') ?? "";
    setRxRequestStatus(Status.LOADING);
    _api.RestroTrackApi(token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      RestroTrackSet(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      setRxRequestStatus(Status.ERROR);
    });
  }
}
