import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayListProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isPlaying = false;
  bool _isDisposed = false;

  AudioPlayer get audioPlayer => _audioPlayer;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  bool get isPlaying => _isPlaying;

  PlayListProvider() {
    listenToDuration();
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      if (!_isDisposed) {
        _totalDuration = newDuration;
        notifyListeners();
      }
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      if (!_isDisposed) {
        _currentDuration = newPosition;
        notifyListeners();
      }
    });

    // şarkı değişimi
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!_isDisposed) {
        _isPlaying = state == PlayerState.playing;
        notifyListeners();
      }
    });
  }

  Future<void> play(String assetPath) async {
    await _audioPlayer.stop(); // var olanı durdur
    await _audioPlayer.play(AssetSource(assetPath));
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  void dispose() {
    _isDisposed = true;
    _audioPlayer.dispose();
    super.dispose();
  }
}
