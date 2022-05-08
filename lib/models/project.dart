import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
part 'project.g.dart';

@JsonSerializable(explicitToJson: true)
class Project {
  String nameProject;
  String user;
  late String id;
  Duration totalTime = const Duration(days: 1000);
  Duration elapsedTime = const Duration();

  Project({
    required this.nameProject,
    required this.user,
    this.totalTime = const Duration(),
  }) {
    var uuid = const Uuid();
    id = uuid.v1();
  }

  addTime(int seconds) {
    Duration time = Duration(seconds: seconds);
    elapsedTime += time;
  }

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
