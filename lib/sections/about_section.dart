import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../core/theme/app_colors.dart';
import '../../core/data/portfolio_data.dart';
import '../../core/utils/icon_helper.dart';
import '../../core/widgets/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(title: 'About Me'),
          const SizedBox(height: 40),
          Text(
                PortfolioData.data['personalInfo']?['about'] ?? 'Flutter developer with 2+ years of experience integrating modern backends.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                  height: 1.8,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              )
              .animate()
              .fadeIn(delay: 500.ms, duration: 600.ms)
              .slideY(begin: 0.2, end: 0),
          SizedBox(height: isMobile ? 32 : 60),
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = isMobile 
                  ? (constraints.maxWidth - 24) / 2 // 2 columns with 24 spacing
                  : 260.0;
              
              final statsList = List<Map<String, dynamic>>.from(
                PortfolioData.data['stats'] ?? [],
              );

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: statsList.map((stat) => _StatCard(
                      width: cardWidth,
                      title: stat['title'] ?? '',
                      subtitle: stat['subtitle'] ?? '',
                      icon: FaIcon(
                        IconHelper.getIcon(stat['icon'] ?? ''),
                        size: isMobile ? 32 : 40,
                        color: AppColors.secondary,
                      ),
                    )).toList().animate(interval: 200.ms).fadeIn(duration: 500.ms).scale(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget icon;
  final double width;

  const _StatCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.width,
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: widget.width,
        constraints: BoxConstraints(minHeight: isMobile ? 140 : 200),
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: (isHovered || isMobile)
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(
                      alpha: isMobile ? 0.2 : 0.3,
                    ),
                    blurRadius: isMobile ? 15 : 20,
                    offset: Offset(0, isMobile ? 5 : 10),
                  ),
                ]
              : [],
          border: Border.all(
            color: (isHovered || isMobile)
                ? AppColors.primary.withValues(alpha: isMobile ? 0.3 : 0.5)
                : Colors.transparent,
            width: 1,
          ),
        ),
        transform: isHovered
            ? Matrix4.translationValues(0.0, -8.0, 0.0)
            : isMobile
                ? Matrix4.translationValues(0.0, -4.0, 0.0)
                : Matrix4.identity(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon,
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: isMobile ? 15 : 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.subtitle,
              style: TextStyle(
                fontSize: isMobile ? 12 : 14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
