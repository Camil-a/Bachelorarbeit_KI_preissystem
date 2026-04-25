import 'package:flutter/material.dart';

/// Centralised color palette for the entire app.
/// Import this file and use [AppColors.xxx] instead of inline color values.
class AppColors {
  AppColors._();

  // ── Brand / Primary ────────────────────────────────────────────────────────
  /// Main accent color – predict button, highlighted chart bar, active icons.
  static const Color primary = Color(0xFFE63946);

  // ── Scaffold & AppBar ─────────────────────────────────────────────────────
  static const Color scaffoldBackground = Color(0xFFF5F5F5); // grey.shade100
  static const Color appBarBackground   = Colors.white;

  // ── Form inputs ───────────────────────────────────────────────────────────
  static const Color inputFill      = Color(0xFFF5F5F5); // grey[100]
  static const Color inputBorder    = Color(0xFFBDBDBD); // grey.shade400 — idle border
  static const Color inputValidIcon = Color(0xFF4CAF50); // Colors.green

  // ── Section headers (shared by all form cards and the chart) ──────────────
  static const Color sectionIcon    = Color(0xFF546E7A); // blueGrey[600]
  static const Color sectionLabel   = Color(0xFF455A64); // blueGrey[700]
  static const Color sectionDivider = Color(0xFFE0E0E0); // grey[300]

  // ── Damage tiles – damaged state ─────────────────────────────────────────
  static const Color damagedBackground  = Color(0xFFFFEBEE); // red.shade50
  static const Color damagedBorder      = Color(0xFFE57373); // red.shade300
  static const Color damagedIcon        = Color(0xFFEF5350); // red.shade400
  static const Color damagedText        = Color(0xFFC62828); // red.shade800
  static const Color damagedBadgeText   = Color(0xFFD32F2F); // red.shade700
  static const Color damagedBadgeBorder = Color(0xFFEF9A9A); // red.shade200

  // ── Damage tiles – ok state (no damage) ──────────────────────────────────
  static const Color okBackground = Color(0xFFFAFAFA); // grey.shade50
  static const Color okBorder     = Color(0xFFE0E0E0); // grey.shade300
  static const Color okIcon       = Color(0xFF9E9E9E); // grey.shade500
  static const Color okText       = Color(0xFF616161); // grey.shade700
  static const Color okIndicator  = Color(0xFFBDBDBD); // grey.shade400

  // ── Damage badge – no-damage / all-clear ─────────────────────────────────
  static const Color okBadgeBackground = Color(0xFFE8F5E9); // green.shade50
  static const Color okBadgeBorder     = Color(0xFFA5D6A7); // green.shade200
  static const Color okBadgeText       = Color(0xFF388E3C); // green.shade700

  // ── Prediction result card ────────────────────────────────────────────────
  static const Color resultGradientTop    = Color(0xFF43A047); // green.shade600
  static const Color resultGradientBottom = Color(0xFF66BB6A); // green.shade400

  // ── Price chart ───────────────────────────────────────────────────────────
  static const Color chartGridLine    = Color(0xFFEEEEEE); // grey.shade200
  static const Color chartTooltipBg   = Color(0xFF37474F); // blueGrey.shade800
  static const Color chartTooltipText = Colors.white;
  static const Color chartRefBar      = Color(0xFFB0BEC5); // blueGrey.shade200
  static const Color chartActiveBar   = Color(0xFF607D8B); // blueGrey.shade500
  static const Color chartZoneBudget  = Color(0xFF81C784); // green.shade300
  static const Color chartZoneMid     = Color(0xFF64B5F6); // blue.shade300
  static const Color chartZonePremium = Color(0xFFFFB74D); // orange.shade300
  static const Color chartIndicator   = Color(0xDD000000); // Colors.black87
  static const Color chartAxisLabel   = Color(0xFF757575); // grey[600]

  // ── Car listing card ──────────────────────────────────────────────────────
  static const Color cardPriceBadge = Color(0xFF43A047); // green[600]
  static const Color cardRatingIcon = Color(0xFFFFC107); // Colors.amber
}
