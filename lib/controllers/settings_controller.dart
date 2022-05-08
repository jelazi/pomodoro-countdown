import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pomodoro_countdown/controllers/file_controller.dart';
import 'countdown_controller.dart';

import '../jsons/json_converters.dart';
import '../models/user.dart';
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
  User? currentUser;
  RxBool logIn = false.obs;
  RxBool isCurrentUserAdmin = false.obs;
  List<User> listUsers = [];
  @JsonKey(ignore: true)
  final box = GetStorage();

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
    String? nameUser = box.read('nameUser');
    String? passUser = box.read('passUser');
    if (nameUser != null && passUser != null) {
      currentUser = User(nameUser, passUser);
      logIn.value = true;
      if (currentUser!.name == 'admin' && currentUser!.password == 'pass') {
        currentUser?.isAdmin = true;
        isCurrentUserAdmin.value = true;
        readUsers();
      }
      checkAdminUser(currentUser!);
    }
  }

  readUsers() {
    List? listUsersString = box.read('users');
    if (listUsersString != null && listUsersString.isNotEmpty) {
      for (String userString in listUsersString) {
        User user = User.fromJson(jsonDecode(userString));
        listUsers.add(user);
      }
    }
  }

  bool addNewUser(User user) {
    if (listUsers.any((element) => (element.name == user.name))) {
      return false;
    } else {
      listUsers.add(user);
      List<String> listUserString = [];
      for (User user in listUsers) {
        listUserString.add(jsonEncode(user.toJson()));
      }
      FileController _fileController = Get.find();
      _fileController.saveUsers(listUserString);
      return true;
    }
  }

  checkUser(User user) {
    checkAdminUser(user);
    if (listUsers.any((element) =>
        (element.name == user.name && element.password == user.password))) {
      logIn.value = true;
      currentUser = user;
      saveCurrentUser();
    }
  }

  checkAdminUser(User user) {
    if (user.name == 'admin' && user.password == 'pass') {
      currentUser?.isAdmin = true;
      logIn.value = true;
      currentUser = user;
      saveCurrentUser();
      isCurrentUserAdmin.value = true;
      readUsers();
    } else {
      currentUser?.isAdmin = false;
      isCurrentUserAdmin.value = false;
    }
  }

  saveCurrentUser() {
    if (currentUser != null) {
      box.write('nameUser', currentUser!.name);
      box.write('passUser', currentUser!.password);
    } else {
      box.remove('nameUser');
      box.remove('passUser');
    }
  }

  Locale get language {
    if (nameLanguage.value == 'cs') {
      return const Locale('cs_Cz');
    } else {
      return const Locale('en_Us');
    }
  }

  saveSettingsData() async {
    CountDownController _countDownController = Get.find();

    box.write('rounds', rounds.value);
    box.write('secondsWork', secondsWork.value);
    box.write('secondsBreak', secondsBreak.value);
    box.write('secondsBreakAfterRound', secondsBreakAfterRound.value);
    if (logIn.value) {
      box.write('nameUser', currentUser?.name ?? '');
      box.write('passwordUser', currentUser?.password ?? '');
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
