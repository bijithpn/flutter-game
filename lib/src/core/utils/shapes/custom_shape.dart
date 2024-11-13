import 'dart:math';
import 'dart:ui';

class CustomShapes {
  // Method to convert degrees to radians
  double degToRad(double deg) => deg * (pi / 180.0);

  /// Star shape with a configurable number of points
  Path drawStar(Size size) {
    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  /// Circle shape
  Path drawCircle(Size size) {
    final radius = size.width / 2;
    final path = Path()
      ..addOval(
          Rect.fromCircle(center: Offset(radius, radius), radius: radius));
    return path;
  }

  /// Square shape
  Path drawSquare(Size size) {
    final path = Path()
      ..addRect(Rect.fromLTWH(
          0, 0, size.width, size.width)); // Square with equal width and height
    return path;
  }

  /// Triangle shape
  Path drawTriangle(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0); // Top vertex
    path.lineTo(size.width, size.height); // Bottom right
    path.lineTo(0, size.height); // Bottom left
    path.close();
    return path;
  }

  /// Heart shape
  Path drawHeart(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;
    path.moveTo(width / 2, height * 0.75);

    path.cubicTo(0, height / 2, width / 2, height / 8, width, height / 2);
    path.cubicTo(
        width / 2, height / 8, 0, height / 2, width / 2, height * 0.75);

    path.close();
    return path;
  }

  /// Squiggly line shape
  Path drawSquigglyLine(Size size) {
    final path = Path();
    final amplitude = size.height / 4; // Height of each wave peak
    final wavelength = size.width / 6; // Length of each wave

    path.moveTo(0, size.height / 2);

    for (double x = 0; x <= size.width; x += wavelength) {
      path.quadraticBezierTo(
        x + wavelength / 4,
        size.height / 2 - amplitude,
        x + wavelength / 2,
        size.height / 2,
      );
      path.quadraticBezierTo(
        x + 3 * wavelength / 4,
        size.height / 2 + amplitude,
        x + wavelength,
        size.height / 2,
      );
    }
    return path;
  }

  /// Wavy line shape with more random variation
  Path drawWavyLine(Size size) {
    final path = Path();
    path.moveTo(0, size.height / 2);
    final amplitude = size.height / 3;

    for (double x = 0; x < size.width; x += 10) {
      final y = amplitude * sin(x / size.width * 2 * pi);
      path.lineTo(x, size.height / 2 + y);
    }
    return path;
  }
}
