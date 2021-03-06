import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/countdown_controller.dart';

class StartStopGroupButton extends StatefulWidget {
  const StartStopGroupButton({Key? key}) : super(key: key);

  @override
  State<StartStopGroupButton> createState() => _StartStopGroupButtonState();
}

class _StartStopGroupButtonState extends State<StartStopGroupButton> {
  String startPausedText = 'start'.tr;
  String stopText = 'stop'.tr;
  final CountDownController _countDownController = Get.find();

  ButtonStyle styleBtnEnabled = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.red),
    shape: MaterialStateProperty.all(const CircleBorder()),
    padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
  );
  ButtonStyle styleBtnDisabled = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.grey),
    shape: MaterialStateProperty.all(const CircleBorder()),
    padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _countDownController.startPaused,
              child: Text(_countDownController.startPausedText.value),
              style: styleBtnEnabled,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed:
                  _countDownController.stateCount.value == stateCountdown.play
                      ? _countDownController.stop
                      : null,
              child: Text(_countDownController.stopText.value),
              style:
                  _countDownController.stateCount.value == stateCountdown.play
                      ? styleBtnEnabled
                      : styleBtnDisabled,
            ),
          ),
        ],
      ),
    );
  }
}
