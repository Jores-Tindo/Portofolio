import 'package:flutter/material.dart';
import 'package:portfolio_flutter/core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/project_model.dart';
import 'screenshot_viewer_screen.dart';
import '../../widgets/demo_video_player.dart';
import 'package:url_launcher/url_launcher.dart';

/// Fiche détaillée d'un projet, avec un grand backdrop en tête, la
/// description complète, les technologies utilisées, une galerie de
/// captures d'écran et les liens externes (GitHub, store...).
class ProjectDetailScreen extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final padding = responsive.pageHorizontalPadding;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 340,
            pinned: true,
            backgroundColor: AppColors.background,
            iconTheme: const IconThemeData(color: AppColors.textPrimary),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    project.backdropImagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.surfaceElevated,
                      child: Center(
                        child: Icon(
                          Icons.wallpaper_rounded,
                          size: 56,
                          color: AppColors.textMuted.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, AppColors.background],
                        stops: [0.4, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: padding, vertical: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(project.title,
                    style: AppTextStyles.heroTitle.copyWith(fontSize: 26)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(Icons.calendar_today_rounded,
                        size: 14, color: AppColors.textMuted),
                    Text('${project.year}', style: AppTextStyles.caption),
                    const SizedBox(width: 10),
                    Icon(Icons.category_outlined,
                        size: 14, color: AppColors.textMuted),
                    Text(project.category.label, style: AppTextStyles.caption),
                  ],
                ),
                const SizedBox(height: 20),

                // Actions (liens externes)
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    if (project.githubUrl != null)
                      OutlinedButton.icon(
                        onPressed: () async {
                          // TODO: ouvrir project.githubUrl (ex: package url_launcher)
                          final Uri url = Uri.parse(project.githubUrl!);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Impossible d'ouvrir le lien : ${project.githubUrl}")));
                          }
                        },
                        icon: const Icon(Icons.code_rounded, size: 18),
                        label: const Text('Code source'),
                      ),
                    if (project.storeUrl != null)
                      ElevatedButton.icon(
                        onPressed: () {
                          // TODO: ouvrir project.storeUrl
                        },
                        icon: const Icon(Icons.open_in_new_rounded, size: 18),
                        label: const Text('Voir en ligne'),
                      ),
                  ],
                ),
                const SizedBox(height: 24),

                Text('À propos du projet', style: AppTextStyles.sectionTitle),
                const SizedBox(height: 10),
                Text(project.fullDescription, style: AppTextStyles.bodyLarge),
                const SizedBox(height: 24),

                Text('Technologies utilisées',
                    style: AppTextStyles.sectionTitle),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.techStack
                      .map((tech) => Chip(
                            backgroundColor: AppColors.surfaceElevated,
                            side: const BorderSide(color: AppColors.divider),
                            label: Text(tech,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textPrimary,
                                )),
                          ))
                      .toList(),
                ),

                if (project.screenshotPaths.isNotEmpty) ...[
                  const SizedBox(height: 28),
                  Text('Captures d\'écran', style: AppTextStyles.sectionTitle),
                  const SizedBox(height: 12),
                  Builder(builder: (context) {
                    final bool isWide =
                        project.category == ProjectCategory.logiciel ||
                            project.category == ProjectCategory.backend;
                    final double shotWidth = isWide ? 280 : 130;
                    final double shotHeight = isWide ? 170 : 220;

                    return SizedBox(
                      height: shotHeight,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: project.screenshotPaths.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ScreenshotViewerScreen(
                                    imagePaths: project.screenshotPaths,
                                    initialIndex: index,
                                  ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                project.screenshotPaths[index],
                                width: shotWidth,
                                height: shotHeight,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: 130,
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceElevated,
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: AppColors.divider),
                                  ),
                                  child: Center(
                                    child: Icon(Icons.image_outlined,
                                        color: AppColors.textMuted),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ],

                if (project.demoVideoPath != null) ...[
                  const SizedBox(height: 28),
                  Text('Démonstration', style: AppTextStyles.sectionTitle),
                  const SizedBox(height: 12),
                  DemoVideoPlayer(videoPath: project.demoVideoPath!),
                ],
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
