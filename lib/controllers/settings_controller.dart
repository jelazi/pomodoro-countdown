import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pomodoro_countdown/controllers/countdown_controller.dart';

import '../jsons/json_converters.dart';
import '../models/owner.dart';
import '../others/logger.dart';

part 'settings_controller.g.dart';

@JsonSerializable(explicitToJson: true)
@RxIntConverter()
@RxStringConverter()
@RxBoolConverter()
class SettingsController extends GetxController {
  SettingsController() {
    loadSettingData();
  }
  RxInt rounds = RxInt(3);
  RxInt secondsWork = RxInt(45 * 60);
  RxInt secondsBreak = RxInt(10 * 60);
  RxInt secondsBreakAfterRound = RxInt(20 * 60);
  RxBool warningPause = RxBool(true);
  RxBool warningTimeEndingAfterWork = RxBool(true);
  RxBool warningTimeEndingAfterBreak = RxBool(true);
  RxInt durationPeriodPauseWarning = RxInt(60);
  RxInt durationPeriodFinishedWarning = RxInt(60);
  RxString nameLanguage = RxString('cs');
  Owner? owner;
  RxBool logIn = false.obs;

  factory SettingsController.fromJson(Map<String, dynamic> json) =>
      _$SettingsControllerFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsControllerToJson(this);

  loadSettingData() async {
    logger.v('loadSettingsData');
    final box = GetStorage();
    rounds.value = box.read('rounds') ?? 3;

    secondsWork.value = box.read('secondsWork') ?? 45 * 60;
    secondsBreak.value = box.read('secondsBreak') ?? 10 * 60;
    secondsBreakAfterRound.value =
        box.read('secondsBreakAfterRound') ?? 10 * 60;
    warningPause.value = box.read('warningPause') ?? true;
    warningTimeEndingAfterWork.value =
        box.read('warningTimeEndingAfterWork') ?? true;
    warningTimeEndingAfterBreak.value =
        box.read('warningTimeEndingAfterBreak') ?? true;
    durationPeriodPauseWarning.value =
        box.read('durationPeriodPauseWarning') ?? 60;
    durationPeriodFinishedWarning.value =
        box.read('durationPeriodFinishedWarning') ?? 60;
    String? nameOwner = box.read('nameOwner');
    String? passOwner = box.read('passOwner');
    if (nameOwner != null && passOwner != null) {
      owner = Owner(nameOwner, passOwner);
      logIn.value = true;
    }
  }

  checkOwner(Owner owner) {
    if (owner.name == 'Lubik' && owner.password == 'pass') {
      logger.d(owner.name);
      logIn.value = true;
      this.owner = owner;
      logger.d(logIn.value);
    }
  }

  Locale get language {
    if (nameLanguage.value == 'cs') {
      return Locale('cs_Cz');
    } else {
      return Locale('en_Us');
    }
  }

  saveSettingsData() async {
    CountDownController _countDownController = Get.find();
    final box = GetStorage();
    box.write('rounds', rounds.value);
    box.write('secondsWork', secondsWork.value);
    box.write('secondsBreak', secondsBreak.value);
    box.write('secondsBreakAfterRound', secondsBreakAfterRound.value);
    if (logIn.value) {
      box.write('nameOwner', owner?.name ?? '');
      box.write('passwordOwner', owner?.password ?? '');
    }
    box.write('warningPause', warningPause.value);
    box.write('warningTimeEndingAfterWork', warningTimeEndingAfterWork.value);
    box.write('warningTimeEndingAfterBreak', warningTimeEndingAfterBreak.value);
    box.write('durationPeriodPauseWarning', durationPeriodPauseWarning.value);
    box.write(
        'durationPeriodFinishedWarning', durationPeriodFinishedWarning.value);
    _countDownController.listRounds.value =
        List.generate(rounds.value + 1, (index) => Rx(stateRound.undone));
  }
}
