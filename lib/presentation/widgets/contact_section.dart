import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/responsive.dart';
import 'package:http/http.dart' as http;

/// Section contact : formulaire (nom, email, message) + infos pratiques.
/// L'envoi actuel ouvre le client mail via un lien "mailto:" pré-rempli,
/// en attendant qu'un vrai backend prenne le relais.
class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);

    try {
      final response = await http.post(
        Uri.parse('https://formspree.io/f/xzepdwrz'), //  Mon URL Formspree
        headers: {'Accept': 'application/json'},
        body: {
          'name': _nameController.text,
          'email': _emailController.text,
          'message': _messageController.text,
        },
      );

      if (mounted) {
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Message envoyé, merci ! Je réponds sous peu.')),
          );
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Une erreur est survenue, réessaie plus tard.')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Impossible d\'envoyer le message, vérifie ta connexion.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final padding = responsive.pageHorizontalPadding;

    final infoColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Icon(Icons.mail_outline_rounded,
                size: 16, color: AppColors.accentSecondary),
            const SizedBox(width: 8),
            Text(
              'CONTACT',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.accentSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Une idée de projet ? Discutons-en',
          style: AppTextStyles.sectionTitle.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 14),
        Text(
          'Que ce soit pour une application mobile, un logiciel ou juste '
          'une question technique, je réponds généralement sous 24 à 48h.',
          style: AppTextStyles.bodyLarge,
        ),
        const SizedBox(height: 28),
        _ContactInfoRow(
            icon: Icons.email_outlined, text: AppConstants.emailContact),
        const SizedBox(height: 14),
        _ContactInfoRow(
            icon: Icons.location_on_outlined, text: AppConstants.location),
        const SizedBox(height: 14),
        _ContactInfoRow(
            icon: Icons.circle,
            iconColor: AppColors.success,
            text: AppConstants.availability),
        const SizedBox(height: 24),
        const _SocialLinksRow(),
      ],
    );

    final form = Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _FormField(
              controller: _nameController,
              label: 'Nom',
              icon: Icons.person_outline_rounded,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Ton nom est requis' : null,
            ),
            const SizedBox(height: 16),
            _FormField(
              controller: _emailController,
              label: 'Email',
              icon: Icons.alternate_email_rounded,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty)
                  return 'Ton email est requis';
                final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                if (!regex.hasMatch(v.trim())) return 'Email invalide';
                return null;
              },
            ),
            const SizedBox(height: 16),
            _FormField(
              controller: _messageController,
              label: 'Message',
              icon: Icons.message_outlined,
              maxLines: 5,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Un message est requis'
                  : null,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isSending ? null : _sendMessage,
                icon: _isSending
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send_rounded, size: 18),
                label: Text(_isSending ? 'Ouverture...' : 'Envoyer le message'),
              ),
            ),
          ],
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          responsive.isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: infoColumn),
                    const SizedBox(width: 48),
                    Expanded(flex: 5, child: form),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    infoColumn,
                    const SizedBox(height: 28),
                    form,
                  ],
                ),
        ],
      ),
    );
  }
}

class _ContactInfoRow extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String text;

  const _ContactInfoRow(
      {required this.icon, required this.text, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: iconColor ?? AppColors.textMuted),
        const SizedBox(width: 10),
        Text(text, style: AppTextStyles.body),
      ],
    );
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?) validator;

  const _FormField({
    required this.controller,
    required this.label,
    required this.icon,
    required this.validator,
    this.maxLines = 1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.caption,
        prefixIcon: Icon(icon, size: 18, color: AppColors.textMuted),
        filled: true,
        fillColor: AppColors.surfaceElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}

class _SocialLinksRow extends StatelessWidget {
  const _SocialLinksRow();

  Future<void> _open(String url) async {
    await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
  }

  Future<void> _openEmail() async {
    await launchUrl(Uri.parse('mailto:${AppConstants.emailContact}'));
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _SocialButton(
          icon: Icons.email_outlined,
          label: 'Email',
          onTap: _openEmail,
        ),
        _SocialButton(
          icon: Icons.business_center_outlined,
          label: 'LinkedIn',
          onTap: () => _open(AppConstants.linkedinUrl),
        ),
        _SocialButton(
          icon: Icons.facebook_outlined,
          label: 'Facebook',
          onTap: () => _open(AppConstants.facebookUrl),
        ),
        _SocialButton(
          icon: Icons.chat_outlined,
          label: 'WhatsApp',
          onTap: () => _open(AppConstants.whatsappUrl),
        ),
        _SocialButton(
          icon: Icons.code_rounded,
          label: 'GitHub',
          onTap: () => _open(AppConstants.githubUrl),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: AppColors.textPrimary),
              const SizedBox(width: 6),
              Text(label,
                  style: AppTextStyles.caption
                      .copyWith(color: AppColors.textPrimary)),
            ],
          ),
        ),
      ),
    );
  }
}
