import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tour Companion design tokens, ported verbatim from the Stitch design system
/// (see design/DESIGN.md). Travel domain: lagoon blue accent + sunset support.
class AppColors {
  static const background = Color(0xFFF1F8FA);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceAlt = Color(0xFFE9F3F6);
  static const accent = Color(0xFF0EA5C4);
  static const accentTint = Color(0xFFD6EEF4);
  static const accentPressed = Color(0xFF0C8BA6);
  static const support = Color(0xFFFF9E5E);
  static const textPrimary = Color(0xFF0E2126);
  static const textSecondary = Color(0xFF41595F);
  static const textTertiary = Color(0xFF7C9299);
  static const border = Color(0xFFD4E4E8);
  static const success = Color(0xFF16A34A);
  static const warning = Color(0xFFD97706);
  static const danger = Color(0xFFDC2626);

  /// Soft 2-stop hero gradient used on onboarding + the "What's next" card.
  static const heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, support],
  );
}

class AppRadius {
  static const card = 20.0;
  static const control = 14.0;
  static const input = 12.0;
  static const pill = 999.0;
}

/// Soft-only elevation, no hard/black shadows.
const kCardShadow = [
  BoxShadow(color: Color(0x0A000000), blurRadius: 2, offset: Offset(0, 1)),
  BoxShadow(color: Color(0x0F000000), blurRadius: 24, offset: Offset(0, 8)),
];

class AppTheme {
  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    final textTheme = GoogleFonts.soraTextTheme(base.textTheme).apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.accent,
        secondary: AppColors.support,
        surface: AppColors.surface,
        error: AppColors.danger,
      ),
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      dividerColor: AppColors.border,
    );
  }
}

/// Named text styles matching the design type scale.
class AppText {
  static TextStyle display() => GoogleFonts.sora(
      fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.64, height: 1.15);
  static TextStyle title() =>
      GoogleFonts.sora(fontSize: 20, fontWeight: FontWeight.w600);
  static TextStyle body() =>
      GoogleFonts.sora(fontSize: 16, fontWeight: FontWeight.w400);
  static TextStyle label() =>
      GoogleFonts.sora(fontSize: 14, fontWeight: FontWeight.w500);
  static TextStyle caption() => GoogleFonts.sora(
      fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textSecondary);
}
