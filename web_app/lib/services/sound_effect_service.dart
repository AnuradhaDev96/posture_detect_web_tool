import 'package:audioplayers/audioplayers.dart';

class SoundEffectsService {
  SoundEffectsService._();

  static final SoundEffectsService _instance = SoundEffectsService._();

  factory SoundEffectsService() {
    return _instance;
  }

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAssetSoundEffect(String assetAudio) async {
    await _audioPlayer.play(AssetSource(assetAudio));
  }
}
