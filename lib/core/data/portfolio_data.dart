import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PortfolioData {
  static late final Map<String, dynamic> data;

  static Future<void> load() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/portfolio_data.json',
      );
      data = jsonDecode(jsonString);
    } catch (e) {
      data = {};
      debugPrint('Error loading portfolio data: $e');
    }
  }
}
