import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/buttons/primary_button.dart';
import '../../core/widgets/section_title.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

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
          const SectionTitle(title: 'Get In Touch'),
          const SizedBox(height: 40),
          Text(
                "I'm currently looking for new opportunities.\nWhether you have a question or just want to say hi, I'll try my best to get back to you!",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                  height: 1.6,
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
                  ? (constraints.maxWidth - 24) / 2 
                  : 240.0;

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: [
                  _ContactCard(
                    width: cardWidth,
                    icon: const FaIcon(
                      FontAwesomeIcons.envelope,
                      size: 28,
                      color: AppColors.secondary,
                    ),
                    title: 'Email',
                    value: AppConstants.email.replaceAll('mailto:', ''),
                    onTap: () => _launchUrl(AppConstants.email),
                  ),
                  _ContactCard(
                    width: cardWidth,
                    icon: const FaIcon(
                      FontAwesomeIcons.linkedinIn,
                      size: 28,
                      color: AppColors.secondary,
                    ),
                    title: 'LinkedIn',
                    value: AppConstants.linkedinUrl.split('/').last,
                    onTap: () => _launchUrl(AppConstants.linkedinUrl),
                  ),
                  _ContactCard(
                    width: cardWidth,
                    icon: const FaIcon(
                      FontAwesomeIcons.github,
                      size: 28,
                      color: AppColors.secondary,
                    ),
                    title: 'GitHub',
                    value: AppConstants.githubUrl.split('/').last,
                    onTap: () => _launchUrl(AppConstants.githubUrl),
                  ),
                  _ContactCard(
                    width: cardWidth,
                    icon: const FaIcon(
                      FontAwesomeIcons.whatsapp,
                      size: 28,
                      color: AppColors.secondary,
                    ),
                    title: 'WhatsApp',
                    value: AppConstants.whatsappNumber,
                    onTap: () => _launchUrl(AppConstants.whatsappUrl),
                  ),
                  _ContactCard(
                    width: cardWidth,
                    icon: const FaIcon(
                      FontAwesomeIcons.phone,
                      size: 28,
                      color: AppColors.secondary,
                    ),
                    title: 'Call',
                    value: AppConstants.phoneCallUrl.replaceAll('tel:', ''),
                    onTap: () => _launchUrl(AppConstants.phoneCallUrl),
                  ),
                ].animate(interval: 200.ms).fadeIn(duration: 500.ms).scale(),
              );
            },
          ),
          SizedBox(height: isMobile ? 48 : 80),
          PrimaryButton(
                text: 'Say Hello',
                icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 20),
                onPressed: () => _launchUrl(AppConstants.whatsappUrl),
              )
              .animate()
              .fadeIn(delay: 1000.ms, duration: 500.ms)
              .scale(begin: const Offset(0.8, 0.8)),
          const SizedBox(height: 80),
          Text(
            'Designed & Built by Mohamed Ali',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  final Widget icon;
  final String title;
  final String value;
  final VoidCallback onTap;
  final double width;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
    required this.width,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return InkWell(
      onTap: widget.onTap,
      onHover: (val) => setState(() => isHovered = val),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: widget.width,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : 20, 
          vertical: isMobile ? 20 : 24
        ),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHovered ? AppColors.secondary : Colors.transparent,
            width: 1,
          ),
          boxShadow: isHovered
               ? [
                   BoxShadow(
                     color: AppColors.secondary.withValues(alpha: 0.2),
                     blurRadius: 15,
                     offset: const Offset(0, 8),
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
            ? Matrix4.translationValues(0.0, -8.0, 0.0)
            : Matrix4.identity(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.icon,
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.value,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
