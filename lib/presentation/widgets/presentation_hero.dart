import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/responsive.dart';

/// Section de présentation en haut de l'accueil : grande photo de profil,
/// accroche, statistiques clés et boutons d'action. C'est le premier
/// contact visuel avec le visiteur, avant même la liste des projets.
class PresentationHero extends StatelessWidget {
  final VoidCallback onVoirProjets;
  final VoidCallback onMeContacter;

  const PresentationHero({
    super.key,
    required this.onVoirProjets,
    required this.onMeContacter,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final padding = responsive.pageHorizontalPadding;
    final bool isWide = responsive.isDesktop;

    final textColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Salut, ici le code prend vie, je suis',
            style: AppTextStyles.bodyLarge),
        const SizedBox(height: 4),
        Text(
          AppConstants.developerName,
          style: AppTextStyles.heroTitle.copyWith(fontSize: 42),
        ),
        const SizedBox(height: 14),
        Text(AppConstants.developerTagline, style: AppTextStyles.bodyLarge),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: onVoirProjets,
              icon: const Icon(Icons.apps_rounded, size: 20),
              label: const Text('Voir mes projets'),
            ),
            OutlinedButton.icon(
              onPressed: onMeContacter,
              icon: const Icon(Icons.mail_outline_rounded, size: 18),
              label: const Text('Me contacter'),
            ),
          ],
        ),
        const SizedBox(height: 36),
        Wrap(
          spacing: 36,
          runSpacing: 16,
          children: const [
            _StatItem(
                value: AppConstants.projectsCount, label: 'Projets réalisés'),
            _StatItem(
                value: AppConstants.techCount,
                label: 'Technologies maîtrisées'),
            _StatItem(value: '100%', label: 'Responsive'),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.circle, size: 8, color: AppColors.success),
              const SizedBox(width: 8),
              Text('Ouvert à de nouvelles collaborations',
                  style: AppTextStyles.caption),
            ],
          ),
        ),
      ],
    );

    final photo = _ProfilePhoto(size: isWide ? 320 : 220);

    return Padding(
      padding: EdgeInsets.fromLTRB(padding, 110, padding, 40),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 6, child: textColumn),
                const SizedBox(width: 48),
                Expanded(flex: 4, child: Center(child: photo)),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: photo),
                const SizedBox(height: 28),
                textColumn,
              ],
            ),
    );
  }
}

class _ProfilePhoto extends StatelessWidget {
  final double size;
  const _ProfilePhoto({required this.size});

  @override
  Widget build(BuildContext context) {
    final double width = size;
    final double height = size * 1.6;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accent, width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.35),
            blurRadius: 40,
            spreadRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/images/profile/profile.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: AppTextStyles.sectionTitle.copyWith(
            fontSize: 26,
            color: AppColors.accentSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}
