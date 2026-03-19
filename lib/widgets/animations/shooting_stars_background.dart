import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ShootingStarsBackground extends StatefulWidget {
  final Widget child;
  final int starCount;

  const ShootingStarsBackground({
    super.key,
    required this.child,
    this.starCount = 12,
  });

  @override
  State<ShootingStarsBackground> createState() =>
      _ShootingStarsBackgroundState();
}

class _ShootingStarsBackgroundState extends State<ShootingStarsBackground>
    with TickerProviderStateMixin {
  late List<_ShootingStar> _stars;
  late List<AnimationController> _controllers;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _stars = [];
    _controllers = [];
    _initStars();
  }

  void _initStars() {
    for (int i = 0; i < widget.starCount; i++) {
      _addStar(i);
    }
  }

  void _addStar(int index) {
    final duration = Duration(
      milliseconds: (1200 + _random.nextInt(2000)).toInt(),
    );
    final delay = Duration(milliseconds: _random.nextInt(4000));

    final controller = AnimationController(vsync: this, duration: duration);
    final star = _ShootingStar(
      startX: _random.nextDouble(),
      startY: _random.nextDouble() * 0.7,
      length: 0.06 + _random.nextDouble() * 0.10,
      angle: pi / 4 + (_random.nextDouble() - 0.5) * 0.4,
      opacity: 0.5 + _random.nextDouble() * 0.5,
      thickness: 0.8 + _random.nextDouble() * 1.2,
    );

    _stars.add(star);
    _controllers.add(controller);

    Future.delayed(delay, () {
      if (mounted) {
        controller.repeat(
          period: duration + Duration(milliseconds: _random.nextInt(3000)),
        );
      }
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Shooting stars layer
        Positioned.fill(
          child: AnimatedBuilder(
            animation: Listenable.merge(_controllers),
            builder: (context, _) {
              return CustomPaint(
                painter: _ShootingStarsPainter(
                  stars: _stars,
                  progresses: _controllers
                      .map((c) => c.value)
                      .toList(),
                ),
              );
            },
          ),
        ),
        // Content on top
        widget.child,
      ],
    );
  }
}

class _ShootingStar {
  final double startX;
  final double startY;
  final double length;
  final double angle;
  final double opacity;
  final double thickness;

  const _ShootingStar({
    required this.startX,
    required this.startY,
    required this.length,
    required this.angle,
    required this.opacity,
    required this.thickness,
  });
}

class _ShootingStarsPainter extends CustomPainter {
  final List<_ShootingStar> stars;
  final List<double> progresses;

  _ShootingStarsPainter({
    required this.stars,
    required this.progresses,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < stars.length; i++) {
      final star = stars[i];
      final t = progresses[i];

      // Ease in-out for smooth appearance and disappearance
      final fadeIn = Curves.easeIn.transform(t.clamp(0.0, 0.3) / 0.3);
      final fadeOut = 1.0 - Curves.easeOut.transform(t.clamp(0.7, 1.0) / 1.0);
      final alpha = (fadeIn * fadeOut * star.opacity).clamp(0.0, 1.0);

      if (alpha <= 0) continue;

      // Position of the head of the star as it travels
      final travelDist = t * size.width * 0.6;
      final headX = star.startX * size.width + cos(star.angle) * travelDist;
      final headY = star.startY * size.height + sin(star.angle) * travelDist;

      // Tail endpoint
      final tailLength = star.length * size.width;
      final tailX = headX - cos(star.angle) * tailLength;
      final tailY = headY - sin(star.angle) * tailLength;

      final paint = Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.white.withValues(alpha: alpha),
            AppColors.primary.withValues(alpha: alpha * 0.6),
            Colors.transparent,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(
          Rect.fromPoints(Offset(headX, headY), Offset(tailX, tailY)),
        )
        ..strokeWidth = star.thickness
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      canvas.drawLine(Offset(headX, headY), Offset(tailX, tailY), paint);

      // Bright glowing head dot
      final glowPaint = Paint()
        ..color = Colors.white.withValues(alpha: alpha * 0.9)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      canvas.drawCircle(Offset(headX, headY), star.thickness * 0.9, glowPaint);
    }
  }

  @override
  bool shouldRepaint(_ShootingStarsPainter oldDelegate) => true;
}
