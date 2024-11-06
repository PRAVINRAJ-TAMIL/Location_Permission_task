import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController {
  final Location location = Location();
  var isUpdatingLocation = false.obs;
  var locationInfo = ''.obs;

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      Get.snackbar("Permission Granted", "Location permission granted.");
    } else if (status.isPermanentlyDenied) {
      openAppSettings();

      Get.snackbar("Permission Denied", "Location permission denied.");

      openAppSettings();
    } else {
      Get.snackbar("Permission Denied", "Location permission denied.");
    }
  }

  Future<void> startLocationUpdates() async {
    bool? confirmed = await Get.defaultDialog(
      title: "Confirmation",
      middleText: "Do you want to start location updates?",
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () {
                Get.back(result: true);
              },
            ),
            ElevatedButton(
              child: const Text('No'),
              onPressed: () {
                Get.back(result: false);
              },
            ),
          ],
        ),
      ],
    );

    if (confirmed == true) {
      isUpdatingLocation.value = true;

      updateLocation();
    }
  }

  Future<void> stopLocationUpdates() async {
    isUpdatingLocation.value = false;
    locationInfo.value = '';
  }

  Future<void> updateLocation() async {
    if (!isUpdatingLocation.value) return;

    final locationData = await location.getLocation();
    locationInfo.value =
        'Lat: ${locationData.latitude}' '  Lng: ${locationData.longitude} ';

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('location', locationInfo.value);

    Future.delayed(Duration(seconds: 30), updateLocation);
  }
}
