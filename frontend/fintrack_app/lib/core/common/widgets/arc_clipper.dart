import 'package:flutter/material.dart';

final class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 50); // Adjust height to match the arc
    path.quadraticBezierTo(
      size.width / 2, size.height, // Control point for the arc
      size.width, size.height - 50, // End point of the arc
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
