import 'package:json_annotation/json_annotation.dart';
part 'project.g.dart';

@JsonSerializable(explicitToJson: true)
class Project {
  String nameProject;
  String owner;
  Duration scheduledTime = const Duration(days: 1000);
  Duration elapsedTime = const Duration();

  Project({
    required this.nameProject,
    required this.owner,
    this.scheduledTime = const Duration(),
  });

  addTime(int seconds) {
    Duration time = Duration(seconds: seconds);
    elapsedTime += time;
  }

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
