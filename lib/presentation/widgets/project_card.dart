import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/project_model.dart';

/// Carte "poster" d'un projet, utilisée dans les rangées horizontales.
/// Au survol (web/desktop) ou au tap (mobile), la carte se met en avant,
/// comme sur une plateforme de streaming.
class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final double width;
  final double height;
  final VoidCallback onTap;

  const ProjectCard({
    super.key,
    required this.project,
    required this.width,
    required this.height,
    required this.onTap,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double height = widget.height;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          child: Container(
            width: widget.width,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      Container(
                        height: height,
                        width: widget.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _isHovered
                                ? AppColors.accent
                                : AppColors.divider,
                            width: 1.5,
                          ),
                        ),
                        child: Image.asset(
                          widget.project.posterImagePath,
                          height: height,
                          width: widget.width,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: AppColors.surfaceElevated,
                            child: Center(
                              child: Icon(
                                Icons.image_outlined,
                                color: AppColors.textMuted,
                                size: widget.width * 0.3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Dégradé bas pour lisibilité si un titre est superposé
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: height * 0.4,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: AppColors.posterOverlayGradient,
                            ),
                          ),
                        ),
                      ),
                      if (widget.project.category.name == 'enCours')
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.accentSecondary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'EN COURS',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.background,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.project.title,
                  style: AppTextStyles.cardTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  widget.project.techStack.take(2).join(' · '),
                  style: AppTextStyles.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
