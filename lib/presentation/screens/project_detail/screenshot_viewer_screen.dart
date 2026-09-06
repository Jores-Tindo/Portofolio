import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Visionneuse plein écran pour les captures d'écran d'un projet.
/// Défilement horizontal entre les images (PageView) + zoom sur chacune
/// (InteractiveViewer), comme une galerie photo classique.
class ScreenshotViewerScreen extends StatefulWidget {
  final List<String> imagePaths;
  final int initialIndex;

  const ScreenshotViewerScreen({
    super.key,
    required this.imagePaths,
    required this.initialIndex,
  });

  @override
  State<ScreenshotViewerScreen> createState() => _ScreenshotViewerScreenState();
}

class _ScreenshotViewerScreenState extends State<ScreenshotViewerScreen> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imagePaths.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              return InteractiveViewer(
                minScale: 1,
                maxScale: 4,
                child: Center(
                  child: Image.asset(
                    widget.imagePaths[index],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.textMuted,
                      size: 48,
                    ),
                  ),
                ),
              );
            },
          ),
          // Bouton fermer
          Positioned(
            top: 16,
            right: 16,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.close_rounded,
                    color: Colors.white, size: 28),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          // Indicateur de position (ex: "2 / 5")
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_currentIndex + 1} / ${widget.imagePaths.length}',
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
