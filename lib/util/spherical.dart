import 'dart:math' show asin, atan2, cos, pi, sin, sqrt;

class SphericalUtil {
  static const double _EARTH_RADIUS = 6371000; // in meters

  static double computeDistanceBetween(LatLng from, LatLng to) {
    double latFrom = _toRadians(from.latitude);
    double latTo = _toRadians(to.latitude);
    double deltaLat = _toRadians(to.latitude - from.latitude);
    double deltaLng = _toRadians(to.longitude - from.longitude);

    double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(latFrom) * cos(latTo) * sin(deltaLng / 2) * sin(deltaLng / 2);

    num c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return _EARTH_RADIUS * c;
  }

  static double _toRadians(double degree) {
    return degree * pi / 180;
  }
}

class LatLng {
  final double latitude;
  final double longitude;

  LatLng(this.latitude, this.longitude);
}