import 'package:flutter/material.dart';

/// Représente une catégorie de compétences (ex: Backend, Outils & Tests...)
/// regroupant plusieurs technologies sous un même bloc visuel.
class SkillCategoryModel {
  final String title;
  final IconData icon;
  final Color accentColor;
  final List<String> technologies;

  const SkillCategoryModel({
    required this.title,
    required this.icon,
    required this.accentColor,
    required this.technologies,
  });
}
