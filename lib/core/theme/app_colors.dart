import 'package:flutter/material.dart';

/// Palette inspirée des interfaces de streaming (fond sombre, contraste fort)
/// mais avec une identité "Mobile & Software Developer" plutôt que le rouge
/// Netflix classique : ici un violet/bleu électrique qui évoque le code.
class AppColors {
  AppColors._();

  // Fond
  static const Color background = Color(0xFF0A0A0F);
  static const Color surface = Color(0xFF15151D);
  static const Color surfaceElevated = Color(0xFF1E1E29);

  // Accent principal (remplace le rouge Netflix)
  static const Color accent = Color(0xFF7C4DFF); // violet électrique
  static const Color accentSecondary = Color(0xFF00E5FF); // cyan (touche "mobile")

  // Texte
  static const Color textPrimary = Color(0xFFF5F5F7);
  static const Color textSecondary = Color(0xFFA0A0AC);
  static const Color textMuted = Color(0xFF6B6B76);

  // États
  static const Color success = Color(0xFF3DDC97);
  static const Color divider = Color(0xFF2A2A35);

  // Dégradé utilisé sur les bannières / posters (assombrit le bas de l'image
  // pour que le texte reste lisible par-dessus une photo/capture d'écran)
  static const List<Color> posterOverlayGradient = [
    Colors.transparent,
    Color(0xE60A0A0F),
  ];
}
