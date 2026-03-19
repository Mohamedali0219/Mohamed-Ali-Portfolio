import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const Color background = Color(0xFF000000);      // Pure Black
  static const Color cardBackground = Color(0xFF0E0E10);  // Deep Charcoal

  // Accents
  static const Color primary = Color(0xFF00DCFF);         // Electric Cyan
  static const Color secondary = Color(0xFF0066FF);       // Tech Blue
  static const Color accent = Color(0xFF00FF7F);          // Spring Green

  // Extra gradient color
  static const Color gradientElement = Color(0xFF0044FF);  // Deep Highlight Blue

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);     // Pure White
  static const Color textSecondary = Color(0xFF94A3B8);   // Slate Base 400

  // Primary Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
