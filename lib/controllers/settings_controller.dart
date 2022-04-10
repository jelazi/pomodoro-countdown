import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:json_annotation/json_annotation.dart';

import '../jsons/json_converters.dart';

part 'settings_controller.g.dart';

@JsonSerializable(explicitToJson: true)
@RxIntConverter()
@RxStringConverter()
@RxBoolConverter()
class SettingsController extends GetxController {
  SettingsController() {}
  RxInt rounds = RxInt(3);
  RxInt secondsWork = RxInt(45 * 60);
  RxInt secondsBreak = RxInt(10 * 1);
  RxInt secondsBreakAfterRound = RxInt(20 * 60);
  RxString nameOwner = RxString('Lubik');
  RxString passwordOwner = RxString('');
  RxBool warningPause = RxBool(true);
  RxBool warningTimeEndingAfterWork = RxBool(true);
  RxBool warningTimeEndingAfterBreak = RxBool(true);
  RxInt durationPeriodPauseWarning = RxInt(60);
  RxInt durationPeriodFinishedWarning = RxInt(60);

  factory SettingsController.fromJson(Map<String, dynamic> json) =>
      _$SettingsControllerFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsControllerToJson(this);

  loadSettingDatas() async {
    final box = GetStorage();
    rounds.value = box.read('rounds');
    secondsWork.value = box.read('secondsWork');
    secondsBreak.value = box.read('secondsBreak');
    secondsBreakAfterRound.value = box.read('secondsBreakAfterRound');
    nameOwner.value = box.read('nameOwner');
    passwordOwner.value = box.read('passwordOwner');
    warningPause.value = box.read('warningPause');
    warningTimeEndingAfterWork.value = box.read('warningTimeEndingAfterWork');
    warningTimeEndingAfterBreak.value = box.read('warningTimeEndingAfterBreak');
    durationPeriodPauseWarning.value = box.read('durationPeriodPauseWarning');
    durationPeriodFinishedWarning.value =
        box.read('durationPeriodFinishedWarning');
  }

  saveSettingsDatas() async {
    final box = GetStorage();
    box.write('rounds', rounds.value);
    box.write('secondsWork', secondsWork.value);
    box.write('secondsBreak', secondsBreak.value);
    box.write('secondsBreakAfterRound', secondsBreakAfterRound.value);
    box.write('nameOwner', nameOwner.value);
    box.write('passwordOwner', passwordOwner.value);
    box.write('warningPause', warningPause.value);
    box.write('warningTimeEndingAfterWork', warningTimeEndingAfterWork.value);
    box.write('warningTimeEndingAfterBreak', warningTimeEndingAfterBreak.value);
    box.write('durationPeriodPauseWarning', durationPeriodPauseWarning.value);
    box.write(
        'durationPeriodFinishedWarning', durationPeriodFinishedWarning.value);
  }
}
