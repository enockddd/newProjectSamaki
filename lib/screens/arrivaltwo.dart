// import 'dart:async';
// import 'package:bus_app_screens/util/spherical.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart' as GoogleMaps;
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../location/location.dart';
// import '../services/GoogleMapsServices.dart';
//
//
// class ArrivalScreen extends StatefulWidget {
//   final LatLng source;
//   final LatLng destination;
//
//   ArrivalScreen({
//     Key? key,
//     required this.source,
//     required this.destination,
//   }) : super(key: key);
//
//   @override
//   _ArrivalScreenState createState() => _ArrivalScreenState();
// }
//
// class _ArrivalScreenState extends State<ArrivalScreen> {
//   GoogleMapController? _controller;
//   Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
//   String _duration = "";
//   bool _reachedDestination = false;
//   late LocationData _currentLocation;
//   late StreamSubscription<LocationData> _locationSubscription;
//
//   @override
//   void initState() {
//     super.initState();
//     _addMarker(
//       widget.source,
//       "Source",
//       BitmapDescriptor.defaultMarkerWithHue(120),
//     );
//     _addMarker(
//       widget.destination,
//       "Destination",
//       BitmapDescriptor.defaultMarkerWithHue(0),
//     );
//     _getDirections();
//   }
//
//   @override
//   void dispose() {
//     _locationSubscription.cancel();
//     super.dispose();
//   }
//
//   void _addMarker(LatLng position, String title, BitmapDescriptor icon) {
//     final MarkerId markerId = MarkerId(position.toString());
//     final Marker marker = Marker(
//       markerId: markerId,
//       position: position,
//       infoWindow: InfoWindow(title: title),
//       icon: icon,
//     );
//     setState(() {
//       _markers[markerId] = marker;
//     });
//   }
//
//   void _getDirections() async {
//     final directions = await GoogleMapsServices.getDirections(
//         widget.source.latitude,
//         widget.source.longitude,
//         widget.destination.latitude,
//         widget.destination.longitude);
//     setState(() {
//       _duration = directions.durationText;
//     });
//
//     _locationSubscription = Location.instance.onLocationChanged.listen(
//       (LocationData currentLocation) {
//         setState(() {
//           _currentLocation = currentLocation;
//         });
//         final double distance = SphericalUtil.computeDistanceBetween(
//             widget.destination,
//             LatLng(currentLocation.latitude!, currentLocation.longitude!));
//         if (distance < 50) {
//           // the user is considered to have arrived if they are within 50 meters of the destination
//           setState(() {
//             _reachedDestination = true;
//           });
//           _locationSubscription.cancel();
//         }
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Arrival Details"),
//       ),
//       body: _reachedDestination ? _buildArrivalScreen() : _buildMapScreen(),
//     );
//   }
//
//   Widget _buildMapScreen() {
//     return Column(
//       children: [
//         Expanded(
//           child: GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: widget.source,
//               zoom: 12.0,
//             ),
//             markers: Set<Marker>.of(_markers.values),
//             onMapCreated: (GoogleMapController controller) {
//               _controller = controller;
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             "Estimated arrival time: $_duration",
//             style: TextStyle(fontSize: 20.0),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildArrivalScreen() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Icon(
//           Icons.check_circle,
//           color: Colors.green,
//           size: 80.0,
//         ),
//         SizedBox(height: 16.0),
//         Text(
//           "You have arrived at your destination!",
//           style: TextStyle(
//             fontSize: 24.0,
//             fontWeight: FontWeight.bold,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(height: 16.0),
//         ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text(
//             "Close",
//             style: TextStyle(fontSize: 20.0),
//           ),
//         ),
//       ],
//     );
//   }
// }
