import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationScreen extends StatefulWidget {
  static const routeName = '/location';
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<LocationScreen> {
  // ignore: prefer_const_constructors, unnecessary_new
  late Position _currentPosition;
  // = new Position(longitude: 0, latitude: 0);
  String _currentAddress = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentAddress != "") Text(
                _currentAddress
            ),
            TextButton(
              child: Text("Get location"),
              onPressed: () {
                // Get location here
                _getCurrentLocation();
              },
            ),
          ],
        ),
      ),
    );
  }
  _getCurrentLocation() {
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude,
          _currentPosition.longitude
      );

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}

