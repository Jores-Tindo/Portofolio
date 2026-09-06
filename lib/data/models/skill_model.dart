import 'package:flutter/material.dart';

/// Représente une compétence technique.
/// L'icône utilise IconData (Material/Cupertino), jamais d'emoji.
class SkillModel {
  final String name;
  final IconData icon;

  /// Niveau de maîtrise entre 0.0 et 1.0, utilisé pour une barre de progression.
  final double level;

  const SkillModel({
    required this.name,
    required this.icon,
    required this.level,
  });
}
