import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/data/portfolio_data.dart';

import '../widgets/cards/project_card.dart';
import '../../core/widgets/section_title.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
          const SectionTitle(
            title: 'Actual Mobile Projects',
            lineWidth: 80,
          ),
          SizedBox(height: isMobile ? 40 : 60),
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = ResponsiveBreakpoints.of(context).isMobile;
              final isTablet = ResponsiveBreakpoints.of(context).isTablet;

              double cardWidth;
              if (isMobile) {
                cardWidth = constraints.maxWidth;
              } else if (isTablet) {
                cardWidth = (constraints.maxWidth - 32) / 2;
              } else {
                cardWidth = (constraints.maxWidth - 64) / 3;
              }

              final projectsList = List<Map<String, dynamic>>.from(
                PortfolioData.data['projects'] ?? [],
              );

              final cards = projectsList.map((project) => ProjectCard(
                    title: project['title'] ?? '',
                    description: project['description'] ?? '',
                    imageUrl: project['imageUrl'] ?? '',
                    technologies: List<String>.from(project['technologies'] ?? []),
                    playStoreUrl: project['playStoreUrl'],
                    githubUrl: project['githubUrl'],
                  )).toList();

              return Wrap(
                spacing: 32,
                runSpacing: 32,
                alignment: WrapAlignment.center,
                children: cards.asMap().entries.map((entry) {
                  return SizedBox(
                    width: cardWidth,
                    child: entry.value
                        .animate(delay: (200 * entry.key).ms)
                        .fadeIn(duration: 600.ms)
                        .slideY(begin: 0.2, end: 0),
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
