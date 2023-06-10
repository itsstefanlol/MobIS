// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as loc;

// import '../consts/firebase_consts.dart';

// class ShowMap extends StatefulWidget {
//   static const routeName = '/ShowMap';
//   const ShowMap({super.key});

//   @override
//   State<ShowMap> createState() => _ShowMapState();
// }

// class _ShowMapState extends State<ShowMap> {
//   final loc.Location location = loc.Location();
//   late GoogleMapController _controller;
//   bool _added = false;

//   @override
//   Widget build(BuildContext context) {
//     User? user = authInstance.currentUser;
//     String userId = user!.uid;
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('location').snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if(_added){
//             mymap(snapshot);
//           } 
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//           return GoogleMap(
//             mapType: MapType.normal,
//             markers: {
//               Marker(
//                 position: LatLng(
//                   snapshot.data!.docs.singleWhere(
//                       (element) => element.id == userId)['latitude'],
//                   snapshot.data!.docs.singleWhere(
//                       (element) => element.id == userId)['longitude'],
//                 ),
//                 markerId: MarkerId('id'),
//                 icon: BitmapDescriptor.defaultMarkerWithHue(
//                     BitmapDescriptor.hueRed),
//               )
//             },
//             initialCameraPosition: CameraPosition(
//               target: LatLng(
//                 snapshot.data!.docs
//                     .singleWhere((element) => element.id == userId)['latitude'],
//                 snapshot.data!.docs.singleWhere(
//                     (element) => element.id == userId)['longitude'],
//               ),
//               zoom: 14.47,
//             ),
//             onMapCreated: (GoogleMapController controller) async {
//               setState(() {
//                 _controller = controller;
//                 _added = true;
//               });
//             },
//           );
//         },
//       ),
//     );
//   }

//   Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {
//     User? user = authInstance.currentUser;
//     String userId = user!.uid;
//     await _controller.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(
//             snapshot.data!.docs
//                 .singleWhere((element) => element.id == userId)['latitude'],
//             snapshot.data!.docs
//                 .singleWhere((element) => element.id == userId)['longitude'],
//           ),
//           zoom: 14.47,
//         ),
//       ),
//     );
//   }
// }
