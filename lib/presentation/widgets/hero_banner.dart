import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/responsive.dart';
import '../../data/models/project_model.dart';

/// Grande bannière en haut de la page d'accueil, avec un backdrop, le titre
/// du projet mis en avant, un court résumé et des actions ("Voir le projet",
/// "Détails"). Équivalent du "hero" affiché en haut d'une appli de streaming.
class HeroBanner extends StatelessWidget {
  final ProjectModel featuredProject;
  final VoidCallback onViewDetails;

  const HeroBanner({
    super.key,
    required this.featuredProject,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final padding = responsive.pageHorizontalPadding;
    final double height = responsive.isDesktop ? 480 : 420;

    return SizedBox(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // IMAGE D'ARRIERE PLAN DE LA BANNIERE (BACKDROP DU PROJET MIS EN AVANT)
          Image.asset(
            'assets/images/backdrops/hero_backdrop.jpg',
            fit: BoxFit.cover,
          ),
          // Dégradé pour lisibilité du texte par-dessus l'image de fond
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.background,
                ],
                stops: [0.3, 1.0],
              ),
            ),
          ),
          Positioned(
            left: padding,
            right: padding,
            bottom: 48,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.bolt_rounded,
                          size: 16, color: AppColors.accentSecondary),
                      const SizedBox(width: 6),
                      Text(
                        'PROJET À LA UNE',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.accentSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(featuredProject.title, style: AppTextStyles.heroTitle),
                  const SizedBox(height: 12),
                  Text(
                    featuredProject.shortDescription,
                    style: AppTextStyles.bodyLarge,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: onViewDetails,
                        icon: const Icon(Icons.play_arrow_rounded, size: 20),
                        label: const Text('Voir le projet'),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: onViewDetails,
                        icon: const Icon(Icons.info_outline_rounded, size: 18),
                        label: const Text('Détails'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
