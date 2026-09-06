import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/project_model.dart';
import '../../../data/repositories/portfolio_repository.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/hero_banner.dart';
import '../../widgets/project_row.dart';
import '../../widgets/skill_tile.dart';
import '../project_detail/project_detail_screen.dart';
import '../../widgets/presentation_hero.dart';
import '../../widgets/about_section.dart';
import '../../widgets/section_intro.dart';
import '../../widgets/contact_section.dart';
import '../../widgets/skill_category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PortfolioRepository _repository = PortfolioRepository();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projetsKey = GlobalKey();
  final GlobalKey _competencesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _aProposKey = GlobalKey();

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToKey(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _openProjectDetail(ProjectModel project) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProjectDetailScreen(project: project),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final projects = _repository.getProjects();
    final skillCategories = _repository.getSkillCategories();
    final featured = _repository.getFeaturedProjects().first;

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        onAccueilTap: _scrollToTop,
        onAProposTap: () => _scrollToKey(_aProposKey),
        onProjetsTap: () => _scrollToKey(_projetsKey),
        onCompetencesTap: () => _scrollToKey(_competencesKey),
        onContactTap: () => _scrollToKey(_contactKey),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeroBanner(
              featuredProject: featured,
              onViewDetails: () => _openProjectDetail(featured),
            ),
            const SizedBox(height: 12),
            PresentationHero(
              onVoirProjets: () => _scrollToKey(_projetsKey),
              onMeContacter: () => _scrollToKey(_contactKey),
            ),

            Container(key: _aProposKey, child: const AboutSection()),
            const SizedBox(height: 13),

            // Section compétences
            Padding(
              key: _competencesKey,
              padding: EdgeInsets.symmetric(
                  horizontal: responsive.pageHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Compétences', style: AppTextStyles.sectionTitle),
                  const SizedBox(height: 8),
                  GridView.count(
                    crossAxisCount: responsive.isDesktop
                        ? 3
                        : (responsive.isTablet ? 2 : 1),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.3,
                    children: skillCategories
                        .map((cat) => SkillCategoryCard(category: cat))
                        .toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            //SECTION DES PROJETS REALISES
            // Une rangée par catégorie, façon "genres" de streaming.
            Column(
              key: _projetsKey,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionIntro(
                  icon: Icons.apps_rounded,
                  eyebrow: 'Mes réalisations',
                  title:
                      'Des idées devenues applications, mes projets parlent mieux que mon CV',
                  description:
                      'Chaque projet ci-dessous a été pensé de bout en bout :'
                      ' du besoin identifié jusqu\'à une application stable et utilisable au quotidien.',
                ),
                for (final category in ProjectCategory.values)
                  ProjectRow(
                    title: category.label,
                    projects: _repository.getProjectsByCategory(category),
                    onProjectTap: _openProjectDetail,
                    isWideFormat: category == ProjectCategory.logiciel ||
                        category == ProjectCategory.backend,
                  ),
              ],
            ),

            const SizedBox(height: 32),

            // Pied de page / contact rapide
            Container(key: _contactKey, child: const ContactSection()),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.pageHorizontalPadding,
                vertical: 20,
              ),
              child: const Divider(color: AppColors.divider),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: responsive.pageHorizontalPadding,
                right: responsive.pageHorizontalPadding,
                bottom: 24,
              ),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 8,
                children: [
                  Text(
                    '© ${DateTime.now().year} ${AppConstants.developerName} — Tous droits réservés',
                    style: AppTextStyles.caption,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.bolt_rounded,
                          size: 14, color: AppColors.textMuted),
                      SizedBox(width: 6),
                      Text('Développé avec Flutter',
                          style: AppTextStyles.caption),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
