import 'dart:math';
import 'package:flutter/material.dart';

class FallingStars extends StatefulWidget {
  const FallingStars({Key? key}) : super(key: key);

  @override
  State<FallingStars> createState() => _FallingStarsState();
}

class _FallingStarsState extends State<FallingStars>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<_Star> _stars = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _controller.addListener(() {
      setState(() {
        for (var star in _stars) {
          star.y += star.speed;
          if (star.y > MediaQuery.of(context).size.height) {
            star.y = 0;
            star.x = _random.nextDouble() * MediaQuery.of(context).size.width;
          }
        }
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateStars();
    });
  }

  void _generateStars() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    _stars = List.generate(100, (index) {
      return _Star(
        x: _random.nextDouble() * screenWidth,
        y: _random.nextDouble() * screenHeight,
        radius: _random.nextDouble() * 1.5 + 0.5,
        speed: _random.nextDouble() * 0.5 + 0.2,
        color: Colors.white
            .withValues(alpha: (_random.nextDouble() * 204 + 51) / 255),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _StarsPainter(stars: _stars),
      child: Container(),
    );
  }
}

class _Star {
  double x;
  double y;
  double radius;
  double speed;
  Color color;

  _Star({
    required this.x,
    required this.y,
    required this.radius,
    required this.speed,
    required this.color,
  });
}

class _StarsPainter extends CustomPainter {
  final List<_Star> stars;

  _StarsPainter({required this.stars});

  @override
  void paint(Canvas canvas, Size size) {
    for (var star in stars) {
      final paint = Paint()..color = star.color;
      canvas.drawCircle(Offset(star.x, star.y), star.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
