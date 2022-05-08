// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsController _$SettingsControllerFromJson(Map<String, dynamic> json) =>
    SettingsController()
      ..rounds = const RxIntConverter().fromJson(json['rounds'] as int)
      ..secondsWork =
          const RxIntConverter().fromJson(json['secondsWork'] as int)
      ..secondsBreak =
          const RxIntConverter().fromJson(json['secondsBreak'] as int)
      ..secondsBreakAfterRound =
          const RxIntConverter().fromJson(json['secondsBreakAfterRound'] as int)
      ..warningPause =
          const RxBoolConverter().fromJson(json['warningPause'] as bool)
      ..warningTimeEndingAfterWork = const RxBoolConverter()
          .fromJson(json['warningTimeEndingAfterWork'] as bool)
      ..warningTimeEndingAfterBreak = const RxBoolConverter()
          .fromJson(json['warningTimeEndingAfterBreak'] as bool)
      ..durationPeriodPauseWarning = const RxIntConverter()
          .fromJson(json['durationPeriodPauseWarning'] as int)
      ..durationPeriodFinishedWarning = const RxIntConverter()
          .fromJson(json['durationPeriodFinishedWarning'] as int)
      ..nameLanguage =
          const RxStringConverter().fromJson(json['nameLanguage'] as String)
      ..currentUser = json['currentUser'] == null
          ? null
          : User.fromJson(json['currentUser'] as Map<String, dynamic>)
      ..logIn = const RxBoolConverter().fromJson(json['logIn'] as bool)
      ..isCurrentUserAdmin =
          const RxBoolConverter().fromJson(json['isCurrentUserAdmin'] as bool)
      ..listUsers = (json['listUsers'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SettingsControllerToJson(SettingsController instance) =>
    <String, dynamic>{
      'rounds': const RxIntConverter().toJson(instance.rounds),
      'secondsWork': const RxIntConverter().toJson(instance.secondsWork),
      'secondsBreak': const RxIntConverter().toJson(instance.secondsBreak),
      'secondsBreakAfterRound':
          const RxIntConverter().toJson(instance.secondsBreakAfterRound),
      'warningPause': const RxBoolConverter().toJson(instance.warningPause),
      'warningTimeEndingAfterWork':
          const RxBoolConverter().toJson(instance.warningTimeEndingAfterWork),
      'warningTimeEndingAfterBreak':
          const RxBoolConverter().toJson(instance.warningTimeEndingAfterBreak),
      'durationPeriodPauseWarning':
          const RxIntConverter().toJson(instance.durationPeriodPauseWarning),
      'durationPeriodFinishedWarning':
          const RxIntConverter().toJson(instance.durationPeriodFinishedWarning),
      'nameLanguage': const RxStringConverter().toJson(instance.nameLanguage),
      'currentUser': instance.currentUser?.toJson(),
      'logIn': const RxBoolConverter().toJson(instance.logIn),
      'isCurrentUserAdmin':
          const RxBoolConverter().toJson(instance.isCurrentUserAdmin),
      'listUsers': instance.listUsers.map((e) => e.toJson()).toList(),
    };
