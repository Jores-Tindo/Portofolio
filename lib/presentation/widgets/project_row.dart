import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/responsive.dart';
import '../../data/models/project_model.dart';
import 'project_card.dart';

/// Une rangée horizontale scrollable de projets, regroupés par catégorie.
/// C'est l'élément central de l'interface "façon streaming" : chaque
/// catégorie (mobile, logiciel, backend...) devient une rangée de titres.
class ProjectRow extends StatelessWidget {
  final String title;
  final List<ProjectModel> projects;
  final void Function(ProjectModel project) onProjectTap;
  final bool isWideFormat;

  const ProjectRow({
    super.key,
    required this.title,
    required this.projects,
    required this.onProjectTap,
    this.isWideFormat = false,
  });

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) return const SizedBox.shrink();

    final responsive = Responsive(context);
    final padding = responsive.pageHorizontalPadding;

    // Format paysage et plus large pour les logiciels bureau (captures
    // d'écran larges), portrait pour les applications mobiles.
    final double cardWidth =
        isWideFormat ? responsive.cardWidth * 1.7 : responsive.cardWidth;
    final double cardHeight = isWideFormat ? cardWidth * 0.62 : cardWidth * 1.4;

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Text(title, style: AppTextStyles.sectionTitle),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: cardHeight + 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: padding),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return ProjectCard(
                  project: project,
                  width: cardWidth,
                  height: cardHeight,
                  onTap: () => onProjectTap(project),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
