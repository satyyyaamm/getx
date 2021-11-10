import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsController extends GetxController {
  var initalCameraPosition =
      const CameraPosition(target: LatLng(90.7128, -94.0060), zoom: 11.5).obs;
  late GoogleMapController googleMapController;

  @override
  void onClose() {
    googleMapController.dispose();
    super.onClose();
  }

  void animateToInitalLocation() {
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(initalCameraPosition.value));
  }
}
