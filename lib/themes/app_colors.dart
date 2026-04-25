import 'package:flutter/material.dart';

/// Centralized color tokens for the Event Finder app.
/// Both light and dark palettes live here so every widget
/// can reference semantic names instead of raw hex values.
abstract final class AppColors {
  // ── Brand ──────────────────────────────────────────────
  static const accent = Color(0xFF4F46E5); // Indigo-600
  static const accentLight = Color(0xFF6366F1); // Indigo-500

  // ── Light palette ──────────────────────────────────────
  static const scaffoldLight = Color(0xFFF9FAFB);
  static const surfaceLight = Colors.white;
  static const textPrimaryLight = Color(0xFF1A1A2E);
  static const textSecondaryLight = Color(0xFF6B7280);
  static const accentSoftLight = Color(0xFFEEF2FF);
  static const borderLight = Color(0xFFE5E7EB);
  static const hintLight = Color(0xFF9CA3AF);
  static const labelLight = Color(0xFF374151);
  static const distanceBgLight = Color(0xFFF3F4F6);

  // ── Dark palette ───────────────────────────────────────
  static const scaffoldDark = Color(0xFF0F0F1A);
  static const surfaceDark = Color(0xFF1A1A2E);
  static const textPrimaryDark = Color(0xFFF1F1F4);
  static const textSecondaryDark = Color(0xFF9CA3AF);
  static const accentSoftDark = Color(0xFF1E1B4B);
  static const borderDark = Color(0xFF2D2D44);
  static const hintDark = Color(0xFF6B7280);
  static const labelDark = Color(0xFFD1D5DB);
  static const distanceBgDark = Color(0xFF252540);
}
