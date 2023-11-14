// Flutter: Existing Libraries
import 'package:flutter/material.dart';

// ContainerClipperHelper: Helper Class
class ContainerClipper extends CustomClipper<Path> {
  // GetClip: Override Class Method
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0); // Top Left
    path.lineTo(0, size.height); // Bottom Left
    path.lineTo(size.width, size.height); // Bottom Right
    path.lineTo(size.width - 50, 0); // Top Right

    // Border
    // var borderWidth = 2.0; // Adjust the border width as needed
    // var borderPath = Path();
    // borderPath.lineTo(0, 0); // Top Left
    // borderPath.lineTo(0, size.height); // Bottom Left
    // borderPath.lineTo(size.width, size.height); // Bottom Right
    // borderPath.lineTo(size.width - 50, 0); // Top Right
    // path.addPath(borderPath, const Offset(0, 0));

    return path;
  }

  // ShouldReclip: Override Class Method
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
