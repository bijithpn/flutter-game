import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_games/src/core/utils/shapes/custom_shape.dart';

class Confetti extends StatelessWidget {
  final ConfettiController confettiController;
  final double blastDirection;
  Confetti({
    super.key,
    required this.confettiController,
    this.blastDirection = pi,
  });

  final shapes = CustomShapes();
  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: confettiController,
      blastDirectionality: BlastDirectionality.explosive,
      blastDirection: blastDirection,
      emissionFrequency: 0.03,
      numberOfParticles: 24,
      maxBlastForce: 16,
      minBlastForce: 7,
      gravity: 0.5,
      colors: const [
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.yellow,
        Colors.purple,
        Colors.orange,
      ],
      createParticlePath: (size) {
        final shapeIndex = Random().nextInt(5);
        switch (shapeIndex) {
          case 0:
            return shapes.drawStar(size);
          case 1:
            return shapes.drawCircle(size);
          case 2:
            return shapes.drawSquare(size);
          case 3:
            return shapes.drawHeart(size);
          case 4:
            return shapes.drawSquigglyLine(size);
          default:
            return shapes.drawWavyLine(size);
        }
      },
    );
  }
}
