import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsServices {
  static Future<dynamic> getDirections(
      double latFrom, double longFrom, double latTo, double longTo) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$latFrom,$longFrom&destination=$latTo,$longTo&key=YOUR_API_KEY";

    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> data = json.decode(response.body);

    String duration = data["routes"][0]["legs"][0]["duration"]["text"];

    return {
      'distance': '',
      'time': duration,
    };
  }
}