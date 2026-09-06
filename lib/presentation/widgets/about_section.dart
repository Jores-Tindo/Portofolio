import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/responsive.dart';

/// Section "À propos" : description complète du parcours et une fiche
/// d'informations claires (nom, spécialité, stack, localisation...).
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final padding = responsive.pageHorizontalPadding;

    final infoCard = Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(label: 'Nom', value: AppConstants.developerName),
          _InfoRow(label: 'Spécialité', value: AppConstants.developerTitle),
          _InfoRow(label: 'Stack principale', value: AppConstants.mainStack),
          _InfoRow(label: 'Localisation', value: AppConstants.location),
          _InfoRow(
              label: 'Disponibilité',
              value: AppConstants.availability,
              isLast: true),
        ],
      ),
    );

    final textBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Icon(Icons.person_outline_rounded,
                size: 16, color: AppColors.accentSecondary),
            const SizedBox(width: 8),
            Text(
              'À PROPOS',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.accentSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text('Mon parcours et ma vision',
            style: AppTextStyles.sectionTitle.copyWith(fontSize: 24)),
        const SizedBox(height: 16),
        Text(AppConstants.aboutParagraph1, style: AppTextStyles.bodyLarge),
        const SizedBox(height: 12),
        Text(AppConstants.aboutParagraph2, style: AppTextStyles.bodyLarge),
      ],
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 40),
      child: responsive.isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 6, child: textBlock),
                const SizedBox(width: 48),
                Expanded(flex: 4, child: infoCard),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textBlock,
                const SizedBox(height: 24),
                infoCard,
              ],
            ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;

  const _InfoRow(
      {required this.label, required this.value, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(label, style: AppTextStyles.caption),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.cardTitle,
            ),
          ),
        ],
      ),
    );
  }
}
