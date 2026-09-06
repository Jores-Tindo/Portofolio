import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/skill_category_model.dart';

/// Carte décorée présentant une catégorie de compétences (ex: Backend,
/// Outils & Tests...) avec une icône dédiée et ses technologies en chips.
/// Pensée pour un rendu marqué "mobile / logiciel", pas un simple tableau.
class SkillCategoryCard extends StatefulWidget {
  final SkillCategoryModel category;

  const SkillCategoryCard({super.key, required this.category});

  @override
  State<SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<SkillCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final category = widget.category;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _isHovered ? category.accentColor : AppColors.divider,
            width: 1.4,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: category.accentColor.withOpacity(0.25),
                    blurRadius: 24,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: category.accentColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(category.icon, color: category.accentColor, size: 22),
            ),
            const SizedBox(height: 16),
            Text(category.title,
                style: AppTextStyles.sectionTitle.copyWith(fontSize: 17)),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: category.technologies
                  .map((tech) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceElevated,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.divider),
                        ),
                        child: Text(
                          tech,
                          style: AppTextStyles.caption
                              .copyWith(color: AppColors.textPrimary),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
