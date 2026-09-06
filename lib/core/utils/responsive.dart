import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Petit utilitaire pour adapter l'interface entre mobile, tablette et web
/// desktop, puisque le portfolio doit être présentable partout.
class Responsive {
  final BuildContext context;
  Responsive(this.context);

  double get width => MediaQuery.of(context).size.width;

  bool get isMobile => width < AppConstants.breakpointMobile;
  bool get isTablet =>
      width >= AppConstants.breakpointMobile && width < AppConstants.breakpointTablet;
  bool get isDesktop => width >= AppConstants.breakpointTablet;

  /// Largeur d'une carte de projet dans les rangées horizontales,
  /// selon la taille d'écran.
  double get cardWidth {
    if (isDesktop) return 220;
    if (isTablet) return 180;
    return 140;
  }

  /// Marge horizontale globale du contenu.
  double get pageHorizontalPadding {
    if (isDesktop) return 64;
    if (isTablet) return 32;
    return 16;
  }
}
