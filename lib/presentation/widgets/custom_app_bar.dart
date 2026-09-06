import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/responsive.dart';

/// Barre de navigation supérieure, fixe et semi-transparente comme sur
/// les plateformes de streaming (elle s'assombrit au scroll si besoin).
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAccueilTap;
  final VoidCallback onAProposTap;
  final VoidCallback onProjetsTap;
  final VoidCallback onCompetencesTap;
  final VoidCallback onContactTap;

  const CustomAppBar({
    super.key,
    required this.onAccueilTap,
    required this.onAProposTap,
    required this.onProjetsTap,
    required this.onCompetencesTap,
    required this.onContactTap,
  });

  Future<void> _openCV() async {
    // Le PDF doit être placé dans web/cv/mon_cv.pdf à la racine du projet.
    final uri = Uri.parse('cv/mon_cv.pdf');
    await launchUrl(uri, webOnlyWindowName: '_blank');
  }

  void _openMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 8),
              _MobileMenuItem(
                label: 'Accueil',
                icon: Icons.home_rounded,
                onTap: () {
                  Navigator.pop(sheetContext);
                  onAccueilTap();
                },
              ),
              _MobileMenuItem(
                label: 'À propos',
                icon: Icons.person_outline_rounded,
                onTap: () {
                  Navigator.pop(sheetContext);
                  onAProposTap();
                },
              ),
              _MobileMenuItem(
                label: 'Projets',
                icon: Icons.apps_rounded,
                onTap: () {
                  Navigator.pop(sheetContext);
                  onProjetsTap();
                },
              ),
              _MobileMenuItem(
                label: 'Compétences',
                icon: Icons.insights_rounded,
                onTap: () {
                  Navigator.pop(sheetContext);
                  onCompetencesTap();
                },
              ),
              _MobileMenuItem(
                label: 'Contact',
                icon: Icons.mail_outline_rounded,
                onTap: () {
                  Navigator.pop(sheetContext);
                  onContactTap();
                },
              ),
              const Divider(color: AppColors.divider, height: 24),
              _MobileMenuItem(
                label: 'Mon CV',
                icon: Icons.description_outlined,
                iconColor: AppColors.accent,
                onTap: () {
                  Navigator.pop(sheetContext);
                  _openCV();
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final padding = responsive.pageHorizontalPadding;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 08),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.background.withOpacity(0.95),
            AppColors.background.withOpacity(0.6),
          ],
        ),
      ),
      child: Row(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.surfaceElevated,
                backgroundImage:
                    const AssetImage('assets/images/profile/profile.png'),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    AppConstants.developerName,
                    style: AppTextStyles.sectionTitle.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      shadows: [
                        Shadow(color: AppColors.background, blurRadius: 10),
                      ],
                    ),
                  ),
                  Text(
                    AppConstants.developerTitle,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 15,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          if (responsive.isDesktop) ...[
            _NavItem(
                label: 'Accueil',
                icon: Icons.home_rounded,
                onTap: onAccueilTap),
            _NavItem(
                label: 'À propos',
                icon: Icons.person_outline_rounded,
                onTap: onAProposTap),
            _NavItem(
                label: 'Projets',
                icon: Icons.apps_rounded,
                onTap: onProjetsTap),
            _NavItem(
                label: 'Compétences',
                icon: Icons.insights_rounded,
                onTap: onCompetencesTap),
            _NavItem(
                label: 'Contact',
                icon: Icons.mail_outline_rounded,
                onTap: onContactTap),
            const SizedBox(width: 16),
            _CVButton(onTap: _openCV),
          ] else
            IconButton(
              icon:
                  const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
              onPressed: () => _openMobileMenu(context),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}

class _NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _NavItem(
      {required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surface.withOpacity(0.6),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(icon, size: 16, color: AppColors.textPrimary),
                const SizedBox(width: 6),
                Text(label,
                    style: AppTextStyles.navLabel
                        .copyWith(color: AppColors.textPrimary)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CVButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CVButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.description_outlined, size: 16, color: Colors.white),
              SizedBox(width: 6),
              Text(
                'Mon CV',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileMenuItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onTap;

  const _MobileMenuItem({
    required this.label,
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? AppColors.textPrimary),
      title: Text(label,
          style: AppTextStyles.body.copyWith(color: AppColors.textPrimary)),
      onTap: onTap,
    );
  }
}
