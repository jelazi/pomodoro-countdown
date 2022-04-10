import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:pomodoro_countdown/controllers/ring_controlller.dart';
import 'package:pomodoro_countdown/controllers/settings_controller.dart';
import 'package:pomodoro_countdown/view/dialogs_snackbars/my_snack_bar.dart';

import '../others/logger.dart';

enum stateCountdown {
  play,
  stop,
  pause,
}
enum typeRound {
  breaking,
  working,
}

enum stateRound {
  undone,
  done,
}

class CountDownController extends GetxController {
  final SettingsController _settingsController = Get.find();
  final RingController _ringController = Get.find();

  Rx<stateCountdown> stateCount = Rx(stateCountdown.stop);
  RxString startPausedText = RxString('start'.tr);
  RxString stopText = RxString('stop'.tr);
  RxInt rounds = RxInt(3);
  late AnimationController controller;
  RxInt currentSecondsRound = RxInt(0);
  typeRound currentTypeRound = typeRound.working;
  RxInt currentRound = RxInt(0);
  late Duration currentDuration;
  late PausableTimer timer;
  late TickerProvider tickerProvider;
  RxString currentTypeRoundString = RxString('working'.tr);
  late CustomTimerPainter painter;
  RxString timerString = RxString('');
  late Timer secondTimer;
  Timer? pauseTimer;
  Timer? finishedTimer;
  List<Rx<stateRound>> listRounds = [];
  bool isFromPause = false;

  createAnimationController(TickerProvider ticker) {
    tickerProvider = ticker;
    currentSecondsRound.value = currentTypeRound == typeRound.working
        ? _settingsController.secondsWork.value
        : currentRound.value < rounds.value
            ? _settingsController.secondsBreak.value
            : _settingsController.secondsBreakAfterRound.value;
    restartTimers();
    controller = AnimationController(
      vsync: tickerProvider,
      duration: currentDuration,
    );
    painter = CustomTimerPainter(
      animation: controller,
      color: Colors.red,
    );
    timerString.value =
        '${currentDuration.inMinutes}:${(currentDuration.inSeconds % 60).toString().padLeft(2, '0')}';
    listRounds =
        List.generate(rounds.value + 1, (index) => Rx(stateRound.undone));
  }

  restartTimers() {
    logger.d('restart timers');
    currentDuration = Duration(seconds: currentSecondsRound.value);
    timer = PausableTimer(currentDuration, () {
      _endRound();
    });
  }

  _changedTextStartPaused(stateCountdown state) {
    if (state == stateCountdown.pause) {
      startPausedText.value = 'start'.tr;
    }
    if (state == stateCountdown.play) {
      startPausedText.value = 'pause'.tr;
    }
    if (state == stateCountdown.stop) {
      startPausedText.value = 'start'.tr;
    }
  }

  startPaused() {
    if (stateCount == stateCountdown.pause ||
        stateCount == stateCountdown.stop) {
      if (!isFromPause) {
        if (currentTypeRound == typeRound.working) {
          _ringController.playStartWorking();
        } else {
          _ringController.playStartBreaking();
        }
      }
      stateCount.value = stateCountdown.play;
      currentDuration = Duration(seconds: currentSecondsRound.value);
      controller.reverse(
          from: controller.value == 0.0 ? 1.0 : controller.value);
      const oneDecimal = Duration(milliseconds: 100);
      secondTimer = Timer.periodic(oneDecimal, (Timer timer) {
        Duration duration = controller.duration! * controller.value;
        timerString.value =
            '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
      });

      if (pauseTimer != null) {
        pauseTimer?.cancel();
      }
      if (finishedTimer != null) {
        finishedTimer?.cancel();
      }
      timer.start();
    } else if (stateCount == stateCountdown.play) {
      isFromPause = true;
      stateCount.value = stateCountdown.pause;
      timer.pause();
      secondTimer.cancel();
      controller.stop();
      currentSecondsRound.value = currentDuration.inSeconds;
      pauseTimer = Timer.periodic(
          Duration(
              seconds: _settingsController.durationPeriodPauseWarning.value),
          (timer) {
        warningTimeFinished();
      });
    }
    _changedTextStartPaused(stateCount.value);
  }

  _endRound() {
    isFromPause = false;
    if (currentTypeRound == typeRound.working) {
      _ringController.playStopWorking();
    } else {
      _ringController.playStopBreaking();
    }
    logger.d('round is finished');
    print(currentSecondsRound);
    stateCount.value = stateCountdown.stop;
    _changedTextStartPaused(stateCount.value);
    if (currentTypeRound == typeRound.breaking) {
      currentRound.value++;

      if (currentRound.value > rounds.value) {
        currentRound.value = 0;
        listRounds.forEach((element) {
          element.value = stateRound.undone;
        });
      }
    } else {
      listRounds[currentRound.value].value = stateRound.done;
    }
    currentTypeRound = currentTypeRound == typeRound.working
        ? typeRound.breaking
        : typeRound.working;
    if (currentRound.value == rounds.value &&
        currentTypeRound == typeRound.breaking) {
      currentSecondsRound.value =
          _settingsController.secondsBreakAfterRound.value;
    } else {
      currentSecondsRound.value = currentTypeRound == typeRound.working
          ? _settingsController.secondsWork.value
          : _settingsController.secondsBreak.value;
    }

    restartTimers();
    secondTimer.cancel();
    timerString.value =
        '${currentDuration.inMinutes}:${(currentDuration.inSeconds % 60).toString().padLeft(2, '0')}';
    controller.duration = currentDuration;
    currentTypeRoundString.value = currentTypeRoundString.value == 'working'.tr
        ? 'breaking'.tr
        : 'working'.tr;
    finishedTimer = Timer.periodic(
        Duration(
            seconds: _settingsController.durationPeriodFinishedWarning.value),
        (timer) {
      warningPause();
    });
  }

  warningPause() {
    if (_settingsController.warningPause.value) {
      if (currentTypeRound == typeRound.breaking) {
        MySnackBar.warningSnackBar(
            'Pause'.tr, 'We are waiting to continue breaking.'.tr);
        _ringController.playRingWarning();
      }
      if (currentTypeRound == typeRound.working) {
        MySnackBar.warningSnackBar(
            'Pause'.tr, 'We are waiting to continue working.'.tr);
        _ringController.playRingWarning();
      }
    }
  }

  warningTimeFinished() {
    if (currentTypeRound == typeRound.breaking &&
        _settingsController.warningTimeEndingAfterWork.value) {
      MySnackBar.warningSnackBar(
          'Break is finished'.tr, 'It is time for work.'.tr);
      _ringController.playRingWarning();
    }
    if (currentTypeRound == typeRound.working &&
        _settingsController.warningTimeEndingAfterBreak.value) {
      MySnackBar.warningSnackBar(
          'Work is finished'.tr, 'It is time for rest.'.tr);
      _ringController.playRingWarning();
    }
  }

  int nextSecond() {
    if (currentTypeRound == typeRound.working) {
      if (currentRound == rounds) {
        return _settingsController.secondsBreakAfterRound.value;
      } else {
        return _settingsController.secondsBreak.value;
      }
    } else {
      return _settingsController.secondsWork.value;
    }
  }

  stop() {
    if (stateCount.value != stateCountdown.play) {
      return;
    }
    controller.value = 0;
    timer.cancel();
    _endRound();
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    required this.animation,
    required this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 20.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value || color != old.color;
  }
}
