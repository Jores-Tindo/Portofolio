import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../models/skill_category_model.dart';
import '../models/experience_model.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';

/// Fournit les données du portfolio.
///
/// Pour l'instant les données sont statiques (en dur) pour se concentrer
/// sur le FRONT. Quand la partie BACK sera développée (ex: Dart Frog,
/// Serverpod, ou une API REST), il suffira de remplacer le contenu des
/// méthodes ci-dessous par de vrais appels réseau, sans toucher à l'UI.
class PortfolioRepository {
  List<ProjectModel> getProjects() {
    return [
      ProjectModel(
        id: 'proj-1',
        title: 'FLowDetectX',
        shortDescription:
            'Assurer la sécurité des flux des transactions dans les institutions de Microfinances.',
        fullDescription:
            'Ce projet est pensé dans l\'idée d\implémenter un moteur de règle'
            ' de détection des transactions suspectes dans les institutions de Microfiances'
            ' dans le contexte spécifique du Bénin. Ceci est doté par défaut de certaines règles'
            ' écrites suites à l\'analyses des rapports et des normes émises par les institutions de contrôle'
            ' comme la CENTIF, la BCEAO, GIABA et bien d\'autres. Son atout précieux est qu\'il d\'ispose'
            ' d\'un constructeur bien détaillé de règles de détection qui permettra aux agents de conformités'
            ' d\'écrire de nouvelles règles de détection ou de modifier celles existantes sans même savoir programmer. '
            ' Cet atout precieux permets de faire avancer le moteur et de l\'adapter aux changements'
            ' sans forcément faire appel à un prestatire externe.',
        category: ProjectCategory.logiciel,
        techStack: const [
          'Flutter Desktop',
          'Java-Spring Boot',
          'MySQL',
          'Simulateur de donné PaySim'
        ],
        year: 2026,
        // TODO: image poster réelle du projet
        posterImagePath: 'assets/images/projects/FlowDetectX/Acceuil.png',
        // TODO: image backdrop réelle du projet
        backdropImagePath: 'assets/images/backdrops/AcceuilFlowDetectX.png',
        screenshotPaths: const [
          'assets/images/projects/FlowDetectX/Acceuil.png',
          'assets/images/projects/FlowDetectX/Dashboard.png',
          'assets/images/projects/FlowDetectX/Alertes.png',
          'assets/images/projects/FlowDetectX/Rules_constructor.png'
        ],
        demoVideoPath: 'assets/videos/FlowDetectX/Demo_FlowDetectX.mp4',
        githubUrl: 'https://github.com/Jores-Tindo/FlowDetectX',
        storeUrl: null,
      ),
      ProjectModel(
        id: 'proj-2',
        title: 'Livo',
        shortDescription: 'Avoir un livreur sous la main.',
        fullDescription:
            'Livo, une application mobile de mise en relation de client-livreur. '
            'Ell est pensée pour permettre à un client de trouver instantanément un'
            ' livreur pour lui confier une course. Je deevellope cette application '
            ' pour simplifier la livraison à la demande en y intégrant certaines '
            'fonctionnalités clés commme la géolocalisation en temps réel pour suivre'
            ' le livreur sur une carte, un système de paiement sécurisé directement dans'
            ' l\'application, une mise en relation directe sans intermédiaire et bien d\'autres.',
        category: ProjectCategory.enCours,
        techStack: const ['Flutter', 'Firebase', 'Riverpod', 'API'],
        year: 2026,
        posterImagePath: 'assets/images/projects/Livo/creation_compte.png',
        backdropImagePath: 'assets/images/backdrops/acceuilLivo.png',
        screenshotPaths: const [
          'assets/images/projects/Livo/creation_compte.png',
          'assets/images/projects/Livo/choix_role.png',
          'assets/images/projects/Livo/acceuil_client.png',
        ],
        demoVideoPath: 'assets/videos/Livo_demo.mp4',
        githubUrl: '',
      ),
    ];
  }

  List<ProjectModel> getFeaturedProjects() {
    // Utilisés pour la bannière "hero" en haut de la page d'accueil.
    return getProjects().take(3).toList();
  }

  List<ProjectModel> getProjectsByCategory(ProjectCategory category) {
    return getProjects().where((p) => p.category == category).toList();
  }

  //Carte des compétences

  List<SkillCategoryModel> getSkillCategories() {
    return [
      SkillCategoryModel(
        title: 'Mobile & Frontend',
        icon: Icons.phone_iphone_rounded,
        accentColor: AppColors.accent,
        technologies: const ['Flutter', 'Dart', 'Kotlin', 'XML'],
      ),
      SkillCategoryModel(
        title: 'Backend & Données',
        icon: Icons.dns_rounded,
        accentColor: AppColors.accentSecondary,
        technologies: const [
          'Java-Spring Boot',
          'Dart Frog',
          'PHP',
          'API REST',
          'MySQL',
          'PostgreSQL',
          'Firebase'
        ],
      ),
      SkillCategoryModel(
        title: 'Logiciel & Bureautique',
        icon: Icons.desktop_windows_rounded,
        accentColor: AppColors.success,
        technologies: const ['C++', 'Qt', 'FLutter Desktop'],
      ),
      SkillCategoryModel(
        title: 'Architecture & Pratiques',
        icon: Icons.account_tree_rounded,
        accentColor: AppColors.accent,
        technologies: const ['MVC', 'Git', 'CI/CD'],
      ),
      SkillCategoryModel(
        title: 'Outils & Tests',
        icon: Icons.build_rounded,
        accentColor: AppColors.accentSecondary,
        technologies: const [
          'VS Code',
          'Android Studio',
          'IntelliJ IDEA',
          'Qt Creator',
          'Postman'
        ],
      ),
    ];
  }

  List<ExperienceModel> getExperiences() {
    // TODO: remplacer par ton vrai parcours
    return const [
      ExperienceModel(
        title: 'Stage / Projet de fin d\'études',
        organization: 'CABRO-GROUP SA',
        period: 'Mai 2026 - Juillet 2026',
        description:
            'Résumé de la mission, des responsabilités et des résultats.',
      ),
      ExperienceModel(
        title: 'Formation en informatique de gestion',
        organization: 'Nom de l\'établissement',
        period: '20XX - 20XX',
        description:
            'Cursus suivi, spécialisation, projets académiques marquants.',
      ),
    ];
  }
}
