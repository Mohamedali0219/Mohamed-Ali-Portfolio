import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../core/theme/app_colors.dart';
import '../core/data/portfolio_data.dart';
import '../core/utils/icon_helper.dart';
import '../core/widgets/section_title.dart';

class ExpertiseSection extends StatefulWidget {
  const ExpertiseSection({super.key});

  @override
  State<ExpertiseSection> createState() => _ExpertiseSectionState();
}

class _ExpertiseSectionState extends State<ExpertiseSection> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startScrolling();
  }

  void _startScrolling() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        // Constant slow linear scroll to a very large distance
        _scrollController.animateTo(
          1000000, // Effectively infinite for a session
          duration: const Duration(hours: 10),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    final List<Map<String, dynamic>> expertise = List<Map<String, dynamic>>.from(
      PortfolioData.data['expertise'] ?? [],
    );
    
    final List<Map<String, dynamic>> details = List<Map<String, dynamic>>.from(
      PortfolioData.data['expertiseDetails'] ?? [],
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 60),
      child: Column(
        children: [
          const SectionTitle(
            title: 'CORE EXPERTISE',
            lineWidth: 80,
            letterSpacing: 4,
          ),
          SizedBox(height: isMobile ? 32 : 60),
          SizedBox(
            height: 100,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(), // No manual scroll
              itemCount: 10000, // Very large number
              itemBuilder: (context, index) {
                final item = expertise[index % expertise.length];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: [
                      FaIcon(
                        IconHelper.getIcon(item['icon'] ?? ''),
                        color: AppColors.primary,
                        size: isMobile ? 24 : 30,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        item['name'],
                        style: TextStyle(
                          fontSize: isMobile ? 16 : 22,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 40),
          // Staggered features for importance
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final cardWidth = isMobile
                    ? (constraints.maxWidth - 40) /
                          2 // 2 columns with 40 spacing
                    : 250.0;

                return Wrap(
                  spacing: isMobile ? 16 : 40,
                  runSpacing: isMobile ? 16 : 40,
                  alignment: WrapAlignment.center,
                  children: details.map((detail) => _ExpertiseDetail(
                        width: cardWidth,
                        title: detail['title'] ?? '',
                        desc: detail['desc'] ?? '',
                        icon: IconHelper.getIcon(detail['icon'] ?? ''),
                      )).toList().animate(interval: 200.ms).fadeIn().scale(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpertiseDetail extends StatelessWidget {
  final String title;
  final String desc;
  final dynamic icon;
  final double width;

  const _ExpertiseDetail({
    required this.title,
    required this.desc,
    required this.icon,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      width: width,
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isMobile
              ? AppColors.primary.withValues(alpha: 0.2)
              : Colors.transparent,
        ),
        boxShadow: isMobile
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Column(
        children: [
          FaIcon(
            icon as FaIconData?,
            color: AppColors.secondary,
            size: isMobile ? 28 : 40,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 15 : 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
