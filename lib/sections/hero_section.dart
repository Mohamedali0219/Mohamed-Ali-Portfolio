import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/buttons/primary_button.dart';
import '../widgets/buttons/outline_button.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onViewProjects;
  final VoidCallback? onContactMe;
  final VoidCallback? onViewServices;

  const HeroSection({
    super.key,
    this.onViewProjects,
    this.onContactMe,
    this.onViewServices,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      constraints: BoxConstraints(minHeight: isMobile ? 500 : 700),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 40 : 80,
      ),
      child: isMobile
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _DevImage(),
                const SizedBox(height: 40),
                _HeroText(
                  onViewProjects: onViewProjects,
                  onContactMe: onContactMe,
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: _HeroText(
                    onViewProjects: onViewProjects,
                    onContactMe: onContactMe,
                  ),
                ),
                const Expanded(flex: 2, child: _DevImage()),
              ],
            ),
    );
  }
}

class _HeroText extends StatelessWidget {
  final VoidCallback? onViewProjects;
  final VoidCallback? onContactMe;

  const _HeroText({
    this.onViewProjects,
    this.onContactMe,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Column(
      crossAxisAlignment: ResponsiveBreakpoints.of(context).isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Hello, I'm",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: AppColors.secondary,
          ),
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.5, end: 0),
        const SizedBox(height: 8),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            AppConstants.devName,
            style: textTheme.displayLarge?.copyWith(
              fontSize: isMobile ? 40 : 72,
              height: 1.1,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 600.ms)
            .slideX(begin: -0.2, end: 0),
        const SizedBox(height: 12),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: DefaultTextStyle(
            style: textTheme.displayMedium!.copyWith(
              color: AppColors.primary,
              fontSize: isMobile ? 28 : 40,
              height: 1.2,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  AppConstants.devTitle,
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              isRepeatingAnimation: false,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
              AppConstants.devDescription,
              style: textTheme.bodyLarge?.copyWith(fontSize: 18, height: 1.6),
              textAlign: ResponsiveBreakpoints.of(context).isMobile
                  ? TextAlign.center
                  : TextAlign.left,
            )
            .animate()
            .fadeIn(delay: 600.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 40),
        Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: ResponsiveBreakpoints.of(context).isMobile
                  ? WrapAlignment.center
                  : WrapAlignment.start,
              children: [
                PrimaryButton(
                  text: 'View Projects',
                  icon: const Icon(Icons.rocket_launch, size: 20),
                  onPressed: onViewProjects,
                ),
                OutlineButton(
                  text: 'Download CV',
                  icon: const FaIcon(FontAwesomeIcons.download, size: 20),
                  onPressed: () async {
                    final Uri url = Uri.parse(AppConstants.devCvPath);
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                ),
                OutlineButton(
                  text: 'Contact Me',
                  icon: const FaIcon(FontAwesomeIcons.paperPlane, size: 20),
                  onPressed: onContactMe,
                ),
                OutlineButton(
                  text: 'WhatsApp',
                  icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 20),
                  onPressed: () async {
                    final Uri url = Uri.parse(AppConstants.whatsappUrl);
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                ),
              ],
            )
            .animate()
            .fadeIn(delay: 800.ms, duration: 500.ms),
      ],
    );
  }
}

class _DevImage extends StatelessWidget {
  const _DevImage();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(
            maxWidth: constraints.maxWidth > 400 ? 400 : constraints.maxWidth,
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.5),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8), // Border width
              child: CircleAvatar(
                backgroundImage: AssetImage(AppConstants.devImagePath),
              ),
            ),
          ),
        );
      },
    )
        .animate()
        .fadeIn(delay: 400.ms, duration: 800.ms);
  }
}
