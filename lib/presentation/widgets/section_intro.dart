import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/responsive.dart';

/// Petit bloc de texte introductif utilisé avant une grande section
/// (ex: avant les rangées de projets), avec un label + un titre + un
/// court paragraphe. Réutilisable pour d'autres sections si besoin.
class SectionIntro extends StatelessWidget {
  final IconData icon;
  final String eyebrow;
  final String title;
  final String description;

  const SectionIntro({
    super.key,
    required this.icon,
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        responsive.pageHorizontalPadding,
        24,
        responsive.pageHorizontalPadding,
        20,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: AppColors.accentSecondary),
                const SizedBox(width: 8),
                Text(
                  eyebrow.toUpperCase(),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.accentSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(title,
                style: AppTextStyles.sectionTitle.copyWith(fontSize: 22)),
            const SizedBox(height: 8),
            Text(description, style: AppTextStyles.bodyLarge),
          ],
        ),
      ),
    );
  }
}
