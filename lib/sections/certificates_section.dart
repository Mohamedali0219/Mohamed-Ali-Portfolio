import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../core/theme/app_colors.dart';
import '../../core/data/portfolio_data.dart';
import '../../core/utils/icon_helper.dart';
import '../widgets/cards/certificate_card.dart';
import '../../core/widgets/section_title.dart';

class CertificatesSection extends StatelessWidget {
  const CertificatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final certsList = List<Map<String, dynamic>>.from(
      PortfolioData.data['certificates'] ?? [],
    );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(title: 'Certifications & Trainings'),
          SizedBox(height: isMobile ? 32 : 60),
          Center(
                child: Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  alignment: WrapAlignment.center,
                  children: certsList.map((cert) => CertificateCard(
                        title: cert['title'] ?? '',
                        platform: cert['platform'] ?? '',
                        date: cert['date'] ?? '',
                        icon: FaIcon(
                          IconHelper.getIcon(cert['icon'] ?? ''),
                          color: AppColors.primary,
                          size: isMobile ? 24 : 32,
                        ),
                      )).toList().animate(interval: 200.ms).fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
                ),
              ),
        ],
      ),
    );
  }
}
