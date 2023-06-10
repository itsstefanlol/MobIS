// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:grocery_app/services/show_map.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:url_launcher/url_launcher_string.dart';
// import 'package:location/location.dart' as loc;

// import '../consts/firebase_consts.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_geocoder/geocoder.dart';

// class LocationScreen extends StatefulWidget {
//   static const routeName = '/LocationScreen';

//   const LocationScreen({super.key});

//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   final loc.Location location = loc.Location();
//   StreamSubscription<loc.LocationData>? _locationSubscription;

//   @override
//   void initState() {
//     _askForPermission();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.deepOrange,
//         title: Text('Location'),
//       ),
//       body: Column(children: [
//         TextButton(
//           onPressed: () {
//             _getLocation();
//           },
//           child: Text("Add my location"),
//         ),
//         TextButton(
//           onPressed: () {
//             _listenToLocation();
//           },
//           child: Text("Enable live location"),
//         ),
//         TextButton(
//           onPressed: () {
//             _stopListening();
//           },
//           child: Text("Stop live location"),
//         ),
//         Expanded(
//           child: StreamBuilder(
//             stream:
//                 FirebaseFirestore.instance.collection('location').snapshots(),
//             builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               return ListView.builder(
//                   itemCount: snapshot.data?.docs.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title:
//                           Text(snapshot.data!.docs[index]['name'].toString()),
//                       subtitle: Row(
//                         children: [
//                           Text(snapshot.data!.docs[index]['latitude']
//                               .toString()),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           Text(snapshot.data!.docs[index]['longitude']
//                               .toString()),
//                         ],
//                       ),
//                       trailing: IconButton(
//                         icon: Icon(Icons.directions),
//                         onPressed: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => ShowMap()));
//                               //snapshot.data!.docs[index].id
//                         },
//                       ),
//                     );
//                   });
//             },
//           ),
//         )
//       ]),
//     );
//   }

//   _getLocation() async {
//     try {
//       final loc.LocationData _locationResult = await location.getLocation();
//       User? user = authInstance.currentUser;
//       await FirebaseFirestore.instance
//           .collection('location')
//           .doc(user!.uid)
//           .set({
//         'latitude': _locationResult.latitude,
//         'longitude': _locationResult.longitude,
//         'name': user.displayName,
//       }, SetOptions(merge: true));
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> _listenToLocation() async {
//     User? user = authInstance.currentUser;
//     _locationSubscription = location.onLocationChanged.handleError((onError) {
//       print(onError);
//       _locationSubscription?.cancel();
//       setState(() {
//         _locationSubscription = null;
//       });
//     }).listen((loc.LocationData currentLocation) async {
//       await FirebaseFirestore.instance
//           .collection('location')
//           .doc(user!.uid)
//           .set({
//         'latitude': currentLocation.latitude,
//         'longitude': currentLocation.longitude,
//         'name': user.displayName,
//       }, SetOptions(merge: true));
//     });
//   }

//   _stopListening() {
//     _locationSubscription?.cancel();
//     setState(() {
//       _locationSubscription = null;
//     });
//   }

  
//   _askForPermission() async {
//     var status = await Permission.location.request();
//     if(status.isGranted){
//       print('done');
//     }
//     else if (status.isDenied){
//       _askForPermission();
//     }
//     else if(status.isPermanentlyDenied){
//       openAppSettings();
//     }
//   }

// }
