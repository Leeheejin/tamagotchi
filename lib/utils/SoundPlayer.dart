import 'package:audioplayers/audioplayers.dart';

class SoundPlayer {
  AudioPlayer audioPlayer = AudioPlayer();

  void playFeedSound() {
    audioPlayer.play(AssetSource('feed.mp3'));
  }

  void playWaterSound() {
    audioPlayer.play(AssetSource('water.mp3'));
  }

  void playPlaySound() {
    audioPlayer.play(AssetSource('play.mp3'));
  }
}
