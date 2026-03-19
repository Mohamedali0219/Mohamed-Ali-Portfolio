import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/cards/glass_achievement_card.dart';
import '../../core/widgets/section_title.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Stack(
      children: [
        // Background Glow
        Positioned(
          top: 100,
          right: -100,
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
          ).animate().fadeIn(duration: 1.seconds).scale(begin: const Offset(0.5, 0.5)),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 80,
            vertical: 80,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SectionTitle(title: 'Milestones & Achievements'),
              const SizedBox(height: 80),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Wrap(
                    spacing: 32,
                    runSpacing: 32,
                    alignment: WrapAlignment.center,
                    children: [
                      const GlassAchievementCard(
                        icon: FaIcon(
                          FontAwesomeIcons.rocket,
                          size: 32,
                          color: AppColors.secondary,
                        ),
                        value: 5,
                        subtitle: 'Production Mobile Apps',
                      ),
                      const GlassAchievementCard(
                        icon: FaIcon(
                          FontAwesomeIcons.cartShopping,
                          size: 32,
                          color: AppColors.secondary,
                        ),
                        value: 2,
                        subtitle: 'E-commerce Systems Built',
                      ),
                      const GlassAchievementCard(
                        icon: FaIcon(
                          FontAwesomeIcons.bolt,
                          size: 32,
                          color: AppColors.secondary,
                        ),
                        value: 1.5,
                        suffix: '+',
                        subtitle: 'Years Flutter Experience',
                      ),
                      const GlassAchievementCard(
                        icon: FaIcon(
                          FontAwesomeIcons.chalkboardUser,
                          size: 32,
                          color: AppColors.secondary,
                        ),
                        value: 1,
                        subtitle: 'Programming Instructor Role',
                      ),
                    ]
                        .animate(interval: 200.ms)
                        .fadeIn(duration: 600.ms)
                        .slideY(begin: 0.2, end: 0)
                        .scale(begin: const Offset(0.95, 0.95)),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
