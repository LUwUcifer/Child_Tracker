import 'package:flutter/material.dart';

class AppColors {
  // Background colors
  static const Color background = Color(0xFF0D1117);
  static const Color surface = Color(0xFF161B22);
  
  // Primary colors (purple gradient)
  static const Color primary = Color(0xFF8B5CF6);
  static const Color primaryLight = Color(0xFFA855F7);
  static const Color secondary = Color(0xFF6366F1);
  
  // Text colors
  static const Color textPrimary = Color(0xFFC9D1D9);
  static const Color textSecondary = Color(0xFF8B949E);
  
  // Status colors
  static const Color safe = Color(0xFF3FB950);
  static const Color alert = Color(0xFFF85149);
  static const Color tracking = Color(0xFFA855F7);
  
  // Border colors
  static const Color border = Color(0xFF30363D);
  static const Color borderPurple = Color(0x338B5CF6);
  
  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x0D8B5CF6), Color(0x0A161B22)],
  );
}
