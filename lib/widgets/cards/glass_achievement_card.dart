import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class GlassAchievementCard extends StatefulWidget {
  final Widget icon;
  final double value;
  final String suffix;
  final String subtitle;

  const GlassAchievementCard({
    super.key,
    required this.icon,
    required this.value,
    this.suffix = '',
    required this.subtitle,
  });

  @override
  State<GlassAchievementCard> createState() => _GlassAchievementCardState();
}

class _GlassAchievementCardState extends State<GlassAchievementCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.value).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ]
              : [],
        ),
        transform: isHovered
            ? Matrix4.translationValues(0.0, -10.0, 0.0)
            : Matrix4.identity(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isHovered
                      ? AppColors.secondary.withValues(alpha: 0.5)
                      : Colors.white.withValues(alpha: 0.1),
                  width: 1.5,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.1),
                    Colors.white.withValues(alpha: 0.02),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.secondary.withValues(alpha: 0.1),
                      border: Border.all(
                        color: AppColors.secondary.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: widget.icon,
                  ),
                  const SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      String displayedValue;
                      if (widget.value % 1 == 0) {
                        displayedValue = _animation.value.toInt().toString();
                      } else {
                        displayedValue = _animation.value.toStringAsFixed(1);
                      }
                      return Text(
                        '$displayedValue${widget.suffix}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
