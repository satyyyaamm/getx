import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsController extends GetxController {
  var initalCameraPosition = const CameraPosition(target: LatLng(20.5937, 78.9629), zoom: 11.5);

  Location location = Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? locationData;
  late GoogleMapController googleMapController;

  @override
  void onInit() {
    getUserLocation();
    super.onInit();
  }

  //Request for permission of location to the user
  requestPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  getUserLocation() async {
    locationData = await location.getLocation();
    print("latitude ${locationData!.latitude}");
    print("longitude ${locationData!.longitude}");
    // return locationData;
  }

  currentCameraLocation() {
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(locationData!.latitude!, locationData!.longitude!), zoom: 11.5)));
  }

  @override
  void onClose() {
    googleMapController.dispose();
    super.onClose();
  }

  void animateToInitalLocation() {
    getUserLocation();
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(initalCameraPosition));
  }
}
