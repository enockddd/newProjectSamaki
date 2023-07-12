import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class LocationData {

  final double? latitude;
  final double? longitude;
  final double? accuracy;

  const LocationData({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
  });
}

class Location {
  static final _location = Location();

  static Location get instance => _location;
  static const MethodChannel _channel = const MethodChannel('location');

  static Location? _instance;

  factory Location() {
    _instance ??= Location._();
    return _instance!;
  }

  Location._() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  static const EventChannel _onLocationChanged =
  const EventChannel('location.onLocationChanged');

  Stream<LocationData>? _onLocationChangedStream;

  Future<LocationData> getLocation() async {
    final Map<dynamic, dynamic>? data =
    await _channel.invokeMethod<Map<dynamic, dynamic>>('getLocation');
    return LocationData(
      latitude: data?['latitude']?.toDouble(),
      longitude: data?['longitude']?.toDouble(),
      accuracy: data?['accuracy']?.toDouble(),
    );
  }

  Stream<LocationData> get onLocationChanged {
    _onLocationChangedStream ??= _onLocationChanged.receiveBroadcastStream().map(
          (dynamic event) => LocationData(
        latitude: event['latitude']?.toDouble(),
        longitude: event['longitude']?.toDouble(),
        accuracy: event['accuracy']?.toDouble(),
      ),
    );
    return _onLocationChangedStream!;
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {}

  static void _onLocationChangedHandler(dynamic event) {}
}