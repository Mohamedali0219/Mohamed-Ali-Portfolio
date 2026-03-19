import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../core/theme/app_colors.dart';
import '../../core/data/portfolio_data.dart';
import '../../core/utils/icon_helper.dart';
import '../../core/widgets/section_title.dart';

class TechStackSection extends StatefulWidget {
  const TechStackSection({super.key});

  @override
  State<TechStackSection> createState() => _TechStackSectionState();
}

class _TechStackSectionState extends State<TechStackSection> {
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

  List<Map<String, dynamic>> get categories =>
      List<Map<String, dynamic>>.from(PortfolioData.data['techStack'] ?? []);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 0 : 80, // Full width for mobile scroll
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 0),
            child: const SectionTitle(
              title: 'Technologies & Skills',
              lineWidth: 80,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: isMobile ? 40 : 80),
          isMobile 
            ? Stack(
                alignment: Alignment.centerRight,
                children: [
                  SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Row(
                      children: categories.asMap().entries.map((entry) {
                        final index = entry.key;
                        final category = entry.value;
                        return Padding(
                          padding: EdgeInsets.only(
                            right: index == categories.length - 1 ? 0 : 20,
                          ),
                          child: _SkillCategoryCard(
                            title: category['title'],
                            icon: IconHelper.getIcon(category['icon'] ?? ''),
                            skills: List<String>.from(category['skills'] ?? []),
                            index: index,
                            cardWidth: 300, // Fixed width for mobile scroll
                          ),
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
            : LayoutBuilder(
                builder: (context, constraints) {
                  final isTablet = ResponsiveBreakpoints.of(context).isTablet;
                  final spacing = isTablet ? 24.0 : 32.0;
                  
                  // Calculate columns based on width
                  int columns = 4;
                  if (constraints.maxWidth < 900) {
                    columns = 1;
                  } else if (constraints.maxWidth < 1300) {
                    columns = 2;
                  }
                  
                  final cardWidth = (constraints.maxWidth - (spacing * (columns - 1))) / columns;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    alignment: WrapAlignment.center,
                    children: categories.asMap().entries.map((entry) {
                      final index = entry.key;
                      final category = entry.value;
                      return _SkillCategoryCard(
                        title: category['title'],
                        icon: IconHelper.getIcon(category['icon'] ?? ''),
                        skills: List<String>.from(category['skills'] ?? []),
                        index: index,
                        cardWidth: cardWidth,
                      );
                    }).toList(),
                  );
                },
              ),
        ],
      ),
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  final String title;
  final dynamic icon;
  final List<String> skills;
  final int index;
  final double cardWidth;

  const _SkillCategoryCard({
    required this.title,
    required this.icon,
    required this.skills,
    required this.index,
    required this.cardWidth,
  });

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: widget.cardWidth,
        constraints: BoxConstraints(
          minWidth: isMobile ? 0 : 280,
          maxWidth: isMobile ? double.infinity : 600,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: EdgeInsets.all(isMobile ? 24 : 32),
              decoration: BoxDecoration(
                color: AppColors.cardBackground.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isHovered 
                    ? AppColors.primary.withValues(alpha: 0.8) 
                    : AppColors.primary.withValues(alpha: 0.1),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: isHovered ? 0.2 : 0.05),
                    blurRadius: isHovered ? 25 : 15,
                    spreadRadius: isHovered ? 5 : 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.2),
                          ),
                        ),
                        child: FaIcon(
                          widget.icon as FaIconData?,
                          color: AppColors.secondary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 24 : 32),
                  ...widget.skills.map((skill) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.circleCheck,
                              size: 14,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  skill,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    ).animate(delay: (150 * widget.index).ms).fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0);
  }
}
