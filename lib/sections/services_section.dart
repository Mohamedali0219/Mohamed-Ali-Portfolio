import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../core/theme/app_colors.dart';
import '../../core/data/portfolio_data.dart';
import '../../core/utils/icon_helper.dart';
import '../../core/widgets/section_title.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  final ScrollController _scrollController = ScrollController();
  bool _showArrow = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 50 && _showArrow) {
        setState(() => _showArrow = false);
      } else if (_scrollController.offset <= 50 && !_showArrow) {
        setState(() => _showArrow = true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get services =>
      List<Map<String, dynamic>>.from(PortfolioData.data['services'] ?? []);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 0 : 80, // No horizontal padding on mobile for full-width scroll
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 0),
            child: const SectionTitle(title: 'What I Offer'),
          ),
          SizedBox(height: isMobile ? 40 : 60),
          if (isMobile)
            Stack(
              alignment: Alignment.centerRight,
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Row(
                    children: services.asMap().entries.map((entry) {
                      final index = entry.key;
                      final service = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: _ServiceCard(
                          width: 300,
                          title: service['title'],
                          description: service['description'],
                          icon: FaIcon(
                            IconHelper.getIcon(service['icon'] ?? ''),
                            color: AppColors.secondary,
                            size: isMobile ? 24 : 30,
                          ),
                        )
                            .animate(delay: (150 * index).ms)
                            .fadeIn(duration: 500.ms)
                            .scale(begin: const Offset(0.9, 0.9)),
                      );
                    }).toList(),
                  ),
                ),
                  if (_showArrow)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.2),
                          ),
                        ),
                        child: const Icon(
                          Icons.chevron_right,
                          color: AppColors.secondary,
                          size: 24,
                        ),
                      )
                          .animate(onPlay: (controller) => controller.repeat())
                          .shimmer(duration: 1200.ms, color: AppColors.secondary)
                          .moveX(begin: -5, end: 5, duration: 600.ms, curve: Curves.easeInOutSine)
                          .then()
                          .moveX(begin: 5, end: -5, duration: 600.ms, curve: Curves.easeInOutSine),
                    ).animate().fadeIn(),
              ],
            )
          else
            Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: services.asMap().entries.map((entry) {
                final index = entry.key;
                final service = entry.value;
                return _ServiceCard(
                  width: 280,
                  title: service['title'],
                  description: service['description'],
                  icon: FaIcon(
                    IconHelper.getIcon(service['icon'] ?? ''),
                    color: AppColors.secondary,
                    size: isMobile ? 24 : 30,
                  ),
                )
                    .animate(delay: (150 * index).ms)
                    .fadeIn(duration: 500.ms)
                    .scale(begin: const Offset(0.9, 0.9));
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final String title;
  final String description;
  final Widget icon;
  final double width;

  const _ServiceCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.width,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
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
        constraints: BoxConstraints(minHeight: isMobile ? 260 : 320),
        padding: EdgeInsets.all(isMobile ? 20 : 32),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHovered
                ? AppColors.primary.withValues(alpha: 0.5)
                : Colors.transparent,
            width: 1,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        transform: isHovered
            ? Matrix4.translationValues(0.0, -10.0, 0.0)
            : Matrix4.identity(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: widget.icon,
            ),
            const SizedBox(height: 24),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: isMobile ? 15 : 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              widget.description,
              style: TextStyle(
                fontSize: isMobile ? 12 : 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
