import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_countdown/controllers/settings_controller.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsController _settingsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('settingsScreen'.tr),
      ),
      body: SettingsList(
        lightTheme: const SettingsThemeData(
          settingsListBackground: Colors.black,
          titleTextColor: Colors.red,
          leadingIconsColor: Colors.white,
          settingsTileTextColor: Colors.white,
          tileDescriptionTextColor: Colors.white,
        ),
        sections: [
          SettingsSection(
            title: Text('owner'.tr),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                title: Text('nameOwner'.tr),
                leading: const Icon(Icons.person),
                value: Text(_settingsController.nameOwner.value),
                onPressed: (BuildContext context) {
                  //  Get.dialog(getLogout());
                },
              ),
              SettingsTile.navigation(
                title: Text('password'.tr),
                leading: const Icon(Icons.password),
                value: Text(_settingsController.passwordOwner.value),
                onPressed: (BuildContext context) {
                  // Get.dialog(getPassword());
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('round'.tr),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.repeat),
                title: Text('numberRound'.tr),
                value: Text(_settingsController.rounds.value.toString()),
                onPressed: (BuildContext context) {
                  //  Get.dialog(getDialogHourPrice());
                },
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.work),
                title: Text('workTime'.tr),
                value: Text(_settingsController.secondsWork.value.toString()),
                onPressed: (BuildContext context) {
                  // Get.dialog(getDialogCurrency());
                },
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.bed),
                title: Text('restTime'.tr),
                value: Text(_settingsController.secondsBreak.value.toString()),
                onPressed: (BuildContext context) {
                  //  Get.dialog(getLanguage());
                },
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.bedroom_child),
                title: Text('longRestTime'.tr),
                value: Text(_settingsController.secondsBreakAfterRound.value
                    .toString()),
                onPressed: (BuildContext context) {
                  //  Get.dialog(getLanguage());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
