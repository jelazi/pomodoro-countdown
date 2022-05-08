// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      nameProject: json['nameProject'] as String,
      user: json['user'] as String,
      totalTime:
          Duration(microseconds: json['totalTime'] as int) ?? const Duration(),
    )
      ..id = json['id'] as String
      ..elapsedTime = Duration(microseconds: json['elapsedTime'] as int);

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'nameProject': instance.nameProject,
      'user': instance.user,
      'id': instance.id,
      'totalTime': instance.totalTime.inMicroseconds,
      'elapsedTime': instance.elapsedTime.inMicroseconds,
    };
