import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ArrivalScreen extends StatefulWidget {
  final LatLng source;
  final LatLng destination;
  ArrivalScreen({Key? key, required this.source, required this.destination})
      : super(key: key);

  @override
  _ArrivalScreenState createState() => _ArrivalScreenState();
}

class _ArrivalScreenState extends State<ArrivalScreen> {
  GoogleMapController? _controller;
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  String _duration = "";

  @override
  void initState() {
    super.initState();
    _addMarker(widget.source, "Source", BitmapDescriptor.defaultMarkerWithHue(120));
    _addMarker(widget.destination, "Destination", BitmapDescriptor.defaultMarkerWithHue(0));
    _getDirections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Arrival Details"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: widget.source,
                zoom: 12.0,
              ),
              markers: Set<Marker>.of(_markers.values),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Estimated arrival time: $_duration",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }

  void _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      position: position,
      icon: descriptor,
    );
    _markers[markerId] = marker;
  }

  void _getDirections() async {
    String apiKey = "YOUR_API_KEY_HERE";
    String apiUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${widget.source.latitude},${widget.source.longitude}&destination=${widget.destination.latitude},${widget.destination.longitude}&key=$apiKey";


    var response = await http.get(Uri.parse(apiUrl));
    var result = json.decode(response.body);
    _duration = result["routes"][0]["legs"][0]["duration"]["text"];
    setState(() {});
  }
}




