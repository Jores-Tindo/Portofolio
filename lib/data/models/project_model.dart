import '../../core/constants/app_constants.dart';

/// Représente un projet du portfolio (une application, un logiciel...).
class ProjectModel {
  final String id;
  final String title;
  final String shortDescription;
  final String fullDescription;
  final ProjectCategory category;
  final List<String> techStack;
  final int year;

  /// Chemin de l'image "poster" (format vertical ou carré, utilisée dans
  /// les rangées horizontales de la page d'accueil).
  /// TODO: fournir l'image réelle, ex: 'assets/images/projects/mon_app_poster.png'
  final String posterImagePath;

  /// Chemin de l'image "backdrop" (format large, utilisée en fond de la
  /// page de détail, comme un backdrop de film).
  /// TODO: fournir l'image réelle, ex: 'assets/images/backdrops/mon_app_backdrop.png'
  final String backdropImagePath;

  /// Captures d'écran additionnelles pour la galerie de la page de détail.
  /// TODO: alimenter avec de vraies captures d'écran de l'app/du logiciel
  final List<String> screenshotPaths;

  final String? githubUrl;
  final String? storeUrl; // Play Store / App Store / site web du logiciel
  final String? demoVideoPath;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
    required this.category,
    required this.techStack,
    required this.year,
    required this.posterImagePath,
    required this.backdropImagePath,
    this.screenshotPaths = const [],
    this.githubUrl,
    this.storeUrl,
    this.demoVideoPath,
  });
}
