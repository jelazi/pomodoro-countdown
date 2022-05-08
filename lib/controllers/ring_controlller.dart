import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';

import '../others/logger.dart';

class RingController extends GetxController {
  RxString startWorkingRing = RxString('assets/rings/whistle.mp3');
  RxString stopWorkingRing = RxString('assets/rings/applause.mp3');
  RxString startBreakingRing = RxString('assets/rings/laugh.mp3');
  RxString stopBreakingRing = RxString('assets/rings/applause.mp3');
  RxString warningRing = RxString('assets/rings/small_ring.mp3');
  AssetsAudioPlayer? audioPlayer;

  playStartWorking() {
    _playRing(startWorkingRing.value);
  }

  playStopWorking() {
    _playRing(stopWorkingRing.value);
  }

  playStartBreaking() {
    _playRing(startBreakingRing.value);
  }

  playStopBreaking() {
    _playRing(stopBreakingRing.value);
  }

  playRingWarning() {
    _playRing(warningRing.value);
  }

  _playRing(String pathRing) async {
    logger.v('playRing $pathRing');
    audioPlayer?.stop();
    audioPlayer = AssetsAudioPlayer.newPlayer();
    audioPlayer?.open(
      Audio(pathRing),
      autoStart: true,
      showNotification: true,
    );
  }
}
