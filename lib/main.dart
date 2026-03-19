import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'core/utils/splash_service.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'core/theme/app_theme.dart';
import 'pages/home_page.dart';
import 'core/data/portfolio_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PortfolioData.load();
  usePathUrlStrategy();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SplashService.hide();
    });
    return MaterialApp(
      builder: (context, child) {
        return ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        );
      },
      title: 'Mohamed Ali - Portfolio',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
