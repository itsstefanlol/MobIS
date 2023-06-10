import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  static const routeName = '/LocationScreen';
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Position? currentPosition;
  StreamSubscription<Position>? positionStream;

   @override
  void dispose() {
    super.dispose();
    /// don't forget to cancel stream once no longer needed
    positionStream?.cancel();
  }

  @override
  void initState() {
    super.initState();
    listenToLocationChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geolocator"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Determine position"),
              onPressed: () {
                _determinePosition();
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(currentPosition!=null? '$currentPosition' : '----',),
          ],
        ),
      ),
    );
  }


  void _determinePosition() async {
    // Test if location services are enabled.
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print('Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        print('Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print('Location permissions are permanently denied, we cannot request permissions.');

      /// open app settings so that user changes permissions
      // await Geolocator.openAppSettings();
      // await Geolocator.openLocationSettings();

      return;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    print("Current Position $position");
    setState(() {
      currentPosition = position;
    });
  }

  void getLastKnownPosition() async {
    Position? position = await Geolocator.getLastKnownPosition();
  }

  void listenToLocationChanges() {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position? position) {
        print(position==null? 'Unknown' : '$position');
        setState(() {
          currentPosition = position;
        });
      },
    );
  }

  void calculateDistance() {
    /// startLatitude, startLongitude, endLatitude, endLongitude
    double distanceInMeters = Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
  }

}
