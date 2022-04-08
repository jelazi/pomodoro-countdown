import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_countdown/controllers/countdown_controller.dart';
import 'package:pomodoro_countdown/view/buttons/start_stop_group_buttons.dart';
import 'package:pomodoro_countdown/view/items/tomato_icon.dart';

class MainScreen extends StatefulWidget {
  MainScreen();

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final CountDownController _countDownController = Get.find();

  @override
  void initState() {
    super.initState();
    _countDownController.createAnimationController(this);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Center(
        child: AnimatedBuilder(
            animation: _countDownController.controller,
            builder: (context, child) {
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Obx(
                              () => Text(
                                "Current Round: ".tr +
                                    (_countDownController.currentRound.value +
                                            1)
                                        .toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 15,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _countDownController.listRounds
                                  .map(
                                    (e) => TomatoIcon(e),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Align(
                              alignment: FractionalOffset.center,
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned.fill(
                                      child: CustomPaint(
                                          painter:
                                              _countDownController.painter),
                                    ),
                                    Align(
                                      alignment: FractionalOffset.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Obx(
                                            () => Text(
                                              _countDownController
                                                  .timerString.value,
                                              style: TextStyle(
                                                  fontSize: 40.0,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 15,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Obx(
                              () => Text(
                                _countDownController
                                    .currentTypeRoundString.value,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: StartStopGroupButton(),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
