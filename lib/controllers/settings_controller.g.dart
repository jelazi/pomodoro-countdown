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
      ..nameOwner =
          const RxStringConverter().fromJson(json['nameOwner'] as String)
      ..passwordOwner =
          const RxStringConverter().fromJson(json['passwordOwner'] as String)
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
          const RxStringConverter().fromJson(json['nameLanguage'] as String);

Map<String, dynamic> _$SettingsControllerToJson(SettingsController instance) =>
    <String, dynamic>{
      'rounds': const RxIntConverter().toJson(instance.rounds),
      'secondsWork': const RxIntConverter().toJson(instance.secondsWork),
      'secondsBreak': const RxIntConverter().toJson(instance.secondsBreak),
      'secondsBreakAfterRound':
          const RxIntConverter().toJson(instance.secondsBreakAfterRound),
      'nameOwner': const RxStringConverter().toJson(instance.nameOwner),
      'passwordOwner': const RxStringConverter().toJson(instance.passwordOwner),
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
    };
