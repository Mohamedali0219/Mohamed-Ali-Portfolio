import '../data/portfolio_data.dart';

class AppConstants {
  static Map<String, dynamic> get _info =>
      PortfolioData.data['personalInfo'] ?? {};

  static String get devName => _info['name'] ?? 'Mohamed Ali';
  static String get devTitle => _info['title'] ?? 'Flutter Developer';
  static String get devDescription =>
      _info['description'] ??
      'I build scalable mobile applications using Flutter, Clean Architecture, and modern backend integrations.';

  static String get devImagePath => _info['image'] ?? 'assets/images/my_image.jpg';
  static String get devCvPath => _info['cv'] ?? 'cv.pdf';

  // Social Links
  static String get githubUrl => _info['github'] ?? 'https://github.com/Mohamedali0219';
  static String get linkedinUrl =>
      _info['linkedin'] ?? 'https://www.linkedin.com/in/mohamed-ali-khamis/';
  static String get email => 'mailto:${_info['email'] ?? 'mohamedali.d2002@gmail.com'}';
  static String get whatsappNumber => _info['whatsappNumber'] ?? '+201558044473';
  static String get whatsappUrl =>
      'https://wa.me/${whatsappNumber.replaceAll('+', '')}';
  static String get phoneCallUrl => 'tel:${_info['phone'] ?? '+201558044473'}';
}
