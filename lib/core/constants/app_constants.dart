/// Constantes globales des vraies informations.
class AppConstants {
  AppConstants._();

  // Mes informations
  static const String developerName = 'Jorès TINDO';
  static const String developerTitle = 'Développeur Mobile & Logiciel';
  static const String developerTagline =
      'Je transforme des besoins concrets en applications Mobiles solides utilisables,'
      ' ainsi que des logiciels robustes, du premier écran jusqu\'à la mise en production."';

  static const String githubUrl = 'https://github.com/Jores-Tindo';
  static const String linkedinUrl =
      'https://www.linkedin.com/in/jor%C3%A8s-tindo-a02571343/';
  static const String emailContact = 'joresdev@gmail.com';
  static const String facebookUrl = 'https://www.facebook.com/jj.311740';
  static const String whatsappUrl = 'https://wa.me/22961870691';

  // Points de rupture pour le responsive (mobile / tablette / desktop web)
  static const double breakpointMobile = 600;
  static const double breakpointTablet = 1024;

  static const String projectsCount = '3+';
  static const String techCount = '07+';
  static const String aboutParagraph1 =
      'Développer une application Mobile et ou un Logiciel,'
      ' c\'est s\'intéressé autant à ce qui se passe à l\'écran qu\'à '
      'ce qui tourne derrière : une bonne application, c\'est une interface'
      ' fluide portée par une architecture solide. \n Je suis $developerName,'
      ' je conçois des applications mobiles ainsi que des logiciels qui résolvent de'
      ' vrais problèmes, pas juste des interfaces qui ont l\'air jolies sur une capture d\'écran.';
  static const String aboutParagraph2 =
      'Chaque projet que je livre passe par les mêmes étapes : '
      'comprendre le besoin réel, construire une base technique propre,'
      ' et itérer jusqu\'à ce que ça marche vraiment sur le terrain. '
      'Au fil de mes projets, j\'ai développé des applications avec '
      'Flutter, Dart, java, C++ et diverses technologies pour proposer des solutions '
      'complètes répondant à des besoins concrets. '
      'Ce qui compte pour moi c\'est le résultat :'
      'une application stable, rapide, et agréable à utiliser au quotidien.';

  static const String location = 'Bénin';
  static const String availability = 'Disponible pour des projets';
  static const String mainStack = 'Flutter, Dart & Spring Boot';
}

/// Catégories utilisées pour regrouper les projets en "rangées" façon
/// plateforme de streaming.
enum ProjectCategory {
  mobile,
  logiciel,
  backend,
  enCours,
}

extension ProjectCategoryLabel on ProjectCategory {
  String get label {
    switch (this) {
      case ProjectCategory.mobile:
        return 'Applications Mobiles';
      case ProjectCategory.logiciel:
        return 'Logiciels & Outils';
      case ProjectCategory.backend:
        return 'Backend & APIs';
      case ProjectCategory.enCours:
        return 'Projets en cours';
    }
  }
}
