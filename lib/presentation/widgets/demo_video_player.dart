import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../core/theme/app_colors.dart';

/// Lecteur vidéo pour la section "Démonstration" d'une fiche projet.
/// Affiche la vidéo avec un bouton lecture/pause et une barre de
/// progression simple, dans un cadre aux coins arrondis cohérent
/// avec le reste de l'interface.
class DemoVideoPlayer extends StatefulWidget {
  final String videoPath;

  const DemoVideoPlayer({super.key, required this.videoPath});

  @override
  State<DemoVideoPlayer> createState() => _DemoVideoPlayerState();
}

class _DemoVideoPlayerState extends State<DemoVideoPlayer> {
  late VideoPlayerController _controller;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        if (mounted) setState(() {});
      }).catchError((_) {
        if (mounted) setState(() => _hasError = true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(
        height: 220,
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        child: const Center(
          child: Icon(Icons.videocam_off_outlined,
              color: AppColors.textMuted, size: 40),
        ),
      );
    }

    if (!_controller.value.isInitialized) {
      return Container(
        height: 220,
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: CircularProgressIndicator(
              strokeWidth: 2, color: AppColors.accent),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          GestureDetector(
            onTap: _togglePlay,
            child: AnimatedOpacity(
              opacity: _controller.value.isPlaying ? 0 : 1,
              duration: const Duration(milliseconds: 200),
              child: Container(
                color: Colors.black26,
                child: const Center(
                  child: Icon(Icons.play_arrow_rounded,
                      color: Colors.white, size: 56),
                ),
              ),
            ),
          ),
          VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: AppColors.accent,
              backgroundColor: Colors.white24,
              bufferedColor: Colors.white38,
            ),
          ),
        ],
      ),
    );
  }
}
