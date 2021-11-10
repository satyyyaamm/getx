import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_practice/controller/maps_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreen extends StatelessWidget {
  const GoogleMapsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mapController = Get.put(MapsController());
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: mapController.initalCameraPosition.value,
        onMapCreated: (controller) => mapController.googleMapController = controller,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.location_disabled),
        onPressed: () {
          mapController.animateToInitalLocation;
        },
      ),
    );
  }
}
