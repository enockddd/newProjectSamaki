import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;

import '../util/spherical.dart';

class PolylinePainter extends CustomPainter {
  final List<gmaps.LatLng> polylineCoordinates;
  final Color color;
  final double strokeWidth;

  PolylinePainter({
    required this.polylineCoordinates,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Path path = Path();
    if (polylineCoordinates.isNotEmpty) {
      path.moveTo(polylineCoordinates.first.latitude, polylineCoordinates.first.longitude);
      for (int i = 1; i < polylineCoordinates.length; i++) {
        path.lineTo(polylineCoordinates[i].latitude, polylineCoordinates[i].longitude);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
