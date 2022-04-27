import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pomodoro_countdown/controllers/countdown_controller.dart';
import 'package:pomodoro_countdown/controllers/settings_controller.dart';
import 'package:pomodoro_countdown/models/owner.dart';
import 'package:pomodoro_countdown/view/dialogs_snackbars/my_snack_bar.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../others/logger.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsController _settingsController = Get.find();
  final CountDownController _countDownController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('settingsScreen'.tr),
      ),
      body: Obx(
        () => SettingsList(
          lightTheme: const SettingsThemeData(
            settingsListBackground: Colors.black,
            settingsSectionBackground: Colors.white10,
            titleTextColor: Colors.white,
            leadingIconsColor: Colors.white,
            settingsTileTextColor: Colors.white,
            tileDescriptionTextColor: Colors.white,
          ),
          sections: [
            _settingsController.logIn.value ? ownerSection() : loginSection(),
            SettingsSection(
              title: Text('rounds'.tr),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: const Icon(Icons.repeat),
                  title: Text('numberRound'.tr),
                  value:
                      Text((_settingsController.rounds.value + 1).toString()),
                  onPressed: (BuildContext context) {
                    Get.dialog(getSettingsDialogInt(
                        'roundTitle'.tr,
                        'roundHint'.tr,
                        _settingsController.rounds.value + 1,
                        saveData,
                        'rounds'));
                  },
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.work),
                  title: Text('workTime'.tr),
                  value: Text((_settingsController.secondsWork.value / 60)
                          .truncate()
                          .toString() +
                      'minutes'.tr),
                  onPressed: (BuildContext context) {
                    Get.dialog(getSettingsDialogInt(
                        'workTimeTitle'.tr,
                        'workTimeHint'.tr,
                        (_settingsController.secondsWork.value / 60).truncate(),
                        saveData,
                        'workTime'));
                  },
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.bed),
                  title: Text('restTime'.tr),
                  value: Text((_settingsController.secondsBreak.value / 60)
                          .truncate()
                          .toString() +
                      'minutes'.tr),
                  onPressed: (BuildContext context) {
                    Get.dialog(getSettingsDialogInt(
                        'restTimeTitle'.tr,
                        'restTimeHint'.tr,
                        (_settingsController.secondsBreak.value / 60)
                            .truncate(),
                        saveData,
                        'restTime'));
                  },
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.bedroom_child),
                  title: Text('longRestTime'.tr),
                  value: Text(
                      (_settingsController.secondsBreakAfterRound.value / 60)
                              .truncate()
                              .toString() +
                          'minutes'.tr),
                  onPressed: (BuildContext context) {
                    Get.dialog(getSettingsDialogInt(
                        'longRestTimeTitle'.tr,
                        'longRestTimeHint'.tr,
                        (_settingsController.secondsBreakAfterRound.value / 60)
                            .truncate(),
                        saveData,
                        'longRestTime'));
                  },
                ),
              ],
            ),
            SettingsSection(title: Text('warnings'.tr), tiles: [
              SettingsTile.switchTile(
                leading: const Icon(Icons.pause),
                initialValue: _settingsController.warningPause.value,
                title: Text('warningPause'.tr),
                onToggle: (value) {
                  _settingsController.warningPause.value = value;
                  _settingsController.saveSettingsData();
                },
              ),
              SettingsTile.switchTile(
                leading: const Icon(Icons.work),
                title: Text('warningTimeEndingAfterWork'.tr),
                initialValue:
                    _settingsController.warningTimeEndingAfterWork.value,
                onToggle: (value) {
                  _settingsController.warningTimeEndingAfterWork.value = value;
                  _settingsController.saveSettingsData();
                },
              ),
              SettingsTile.switchTile(
                leading: const Icon(Icons.free_breakfast),
                title: Text('warningTimeEndingAfterBreak'.tr),
                initialValue:
                    _settingsController.warningTimeEndingAfterBreak.value,
                onToggle: (value) {
                  _settingsController.warningTimeEndingAfterBreak.value = value;
                  _settingsController.saveSettingsData();
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.timer_outlined),
                title: Text('durationPeriodPauseWarning'.tr),
                value: Text(_settingsController.durationPeriodPauseWarning.value
                        .toString() +
                    'seconds'.tr),
                onPressed: (BuildContext context) {
                  Get.dialog(getSettingsDialogInt(
                      'durationPeriodPauseWarningTitle'.tr,
                      'durationPeriodPauseWarningHint'.tr,
                      _settingsController.durationPeriodPauseWarning.value,
                      saveData,
                      'durationPeriodPauseWarning'));
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.bedroom_child),
                title: Text('durationPeriodFinishedWarning'.tr),
                value: Text(_settingsController
                        .durationPeriodFinishedWarning.value
                        .toString() +
                    'seconds'.tr),
                onPressed: (BuildContext context) {
                  Get.dialog(getSettingsDialogInt(
                      'durationPeriodFinishedWarningTitle'.tr,
                      'durationPeriodFinishedWarningHint'.tr,
                      _settingsController.durationPeriodFinishedWarning.value,
                      saveData,
                      'durationPeriodFinishedWarning'));
                },
              ),
            ])
          ],
        ),
      ),
    );
  }

  SettingsSection loginSection() {
    return SettingsSection(tiles: <SettingsTile>[
      SettingsTile(
          title: Text('login'.tr),
          leading: const Icon(Icons.login),
          value: const Text(''),
          onPressed: (BuildContext context) {
            loginDialog();
          }),
    ]);
  }

  logOutDialog() {
    Get.dialog(AlertDialog(
      title: Text('logOutTitle'.tr),
      content: Text('logOutQuestion'.tr),
      actions: [
        ElevatedButton(
          onPressed: () {
            _settingsController.logIn.value = false;
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('yes'.tr),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('no'.tr),
        ),
      ],
    ));
  }

  loginDialog() {
    Owner owner = Owner('', '');

    Get.dialog(AlertDialog(
      title: Text('loginTitle'.tr),
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'nameOwner'.tr,
                  hintText: 'putNameOwner'.tr,
                ),
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  setState(() {
                    owner.name = text;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'passOwner'.tr,
                  hintText: 'putPassOwner'.tr,
                ),
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  setState(() {
                    owner.password = text;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            _settingsController.checkOwner(owner);
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('ok'.tr),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('cancel'.tr),
        ),
      ],
    ));
  }

  SettingsSection ownerSection() {
    return SettingsSection(
      title: Text('owner'.tr),
      tiles: <SettingsTile>[
        SettingsTile.navigation(
          title: Text('nameOwner'.tr),
          leading: const Icon(Icons.person),
          value: Text(_settingsController.owner?.name ?? ''),
          onPressed: null,
        ),
        SettingsTile.navigation(
          title: Text('password'.tr),
          leading: const Icon(Icons.password),
          value: Text(_settingsController.owner?.password ?? ''),
          onPressed: null,
        ),
        SettingsTile.navigation(
          title: Text('logout'.tr),
          leading: const Icon(Icons.logout),
          onPressed: (BuildContext context) {
            logOutDialog();
          },
        ),
      ],
    );
  }

  saveData(var newData, String nameData) {
    logger.d('newData: $newData');
    logger.d('namedata: $nameData');
    switch (nameData) {
      case 'rounds':
        {
          _settingsController.rounds.value = (newData - 1);
          _countDownController.resetValues();
          break;
        }
      case 'workTime':
        {
          _settingsController.secondsWork.value = (newData * 60);
          _countDownController.resetValues();
          break;
        }
      case 'restTime':
        {
          _settingsController.secondsBreak.value = (newData * 60);
          _countDownController.resetValues();
          break;
        }
      case 'longRestTime':
        {
          _settingsController.secondsBreakAfterRound.value = (newData * 60);
          _countDownController.resetValues();
          break;
        }
      case 'nameOwner':
        {
          _settingsController.owner?.name = newData;
          break;
        }
      case 'passwordOwner':
        {
          _settingsController.owner?.password = newData;
          break;
        }
      case 'warningPause':
        {
          _settingsController.warningPause.value = newData;
          break;
        }
      case 'durationPeriodPauseWarning':
        {
          _settingsController.durationPeriodPauseWarning.value = newData;
          break;
        }
      case 'durationPeriodFinishedWarning':
        {
          _settingsController.durationPeriodFinishedWarning.value = newData;
          break;
        }

      default:
        {
          logger.e('wrong nameString datas');
        }
    }
    _settingsController.saveSettingsData();
  }

  getSettingsDialogString(
    String titleString,
    String hintText,
    String val,
    Function onPress,
    String nameData,
  ) {
    String value = val;
    return AlertDialog(
      title: Text(titleString),
      content: SizedBox(
        child: TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: value,
            hintText: hintText,
          ),
          keyboardType: TextInputType.text,
          onChanged: (text) {
            setState(() {
              value = text;
            });
          },
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            onPress(value, nameData);
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('ok'.tr),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('cancel'.tr),
        ),
      ],
    );
  }

  getSettingsDialogInt(
    String titleString,
    String hintText,
    int val,
    Function onPress,
    String nameData,
  ) {
    int value = val;
    return AlertDialog(
      title: Text(titleString),
      content: TextField(
        keyboardType:
            const TextInputType.numberWithOptions(decimal: true, signed: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: value.toString(),
          hintText: hintText,
        ),
        onChanged: (text) {
          setState(() {
            if (int.tryParse(text) == null) {
              MySnackBar.warningSnackBar('Error'.tr, 'only number'.tr);
              return;
            }
            value = int.parse(text);
          });
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            onPress(value, nameData);
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('ok'.tr),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('cancel'.tr),
        ),
      ],
    );
  }
}
