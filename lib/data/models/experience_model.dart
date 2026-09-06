/// Représente une expérience professionnelle ou académique marquante.
class ExperienceModel {
  final String title;
  final String organization;
  final String period; // ex: "2024 - Présent"
  final String description;

  const ExperienceModel({
    required this.title,
    required this.organization,
    required this.period,
    required this.description,
  });
}
