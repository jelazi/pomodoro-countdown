import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/countdown_controller.dart';
import '../../controllers/projects_controller.dart';
import '../buttons/start_stop_group_buttons.dart';
import '../items/tomato_icon.dart';

class MainScreen extends StatefulWidget {
  MainScreen();

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final CountDownController _countDownController = Get.find();
  final ProjectsController _projectsController = Get.find();
  final SettingsController _settingsController = Get.find();

  @override
  void initState() {
    super.initState();
    _countDownController.createAnimationController(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Center(
        child: AnimatedBuilder(
            animation: _countDownController.controller,
            builder: (context, child) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 12,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Obx(
                              () => Column(
                                children: [
                                  Visibility(
                                    visible: _settingsController.logIn.value,
                                    child: Text(
                                      _projectsController
                                          .currentProjectName.value,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      "round".tr +
                                          (_countDownController
                                                      .currentRoundNumber
                                                      .value +
                                                  1)
                                              .toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 15,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: _countDownController.listRounds
                                    .map(
                                      (e) => TomatoIcon(e),
                                    )
                                    .toList(),
                              ),
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
                                              style: const TextStyle(
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
                                style: const TextStyle(
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
