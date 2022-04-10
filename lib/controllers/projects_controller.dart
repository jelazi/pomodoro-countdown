import 'package:get/get_state_manager/get_state_manager.dart';

import '../models/project.dart';
import '../others/logger.dart';

class ProjectsController extends GetxController {
  Map<String, Project> projects = {};
  Duration scheduledTime = Duration();
  Project? currentProject;
  ProjectsController();
  bool newProject(String nameProject, String ownerName,
      {Duration scheduledTime = const Duration()}) {
    if (projects.containsKey(nameProject)) return false;
    Project newProject = Project(nameProject: nameProject, owner: ownerName);
    if (scheduledTime.inSeconds != 0) {
      newProject = Project(
        nameProject: nameProject,
        owner: ownerName,
        scheduledTime: scheduledTime,
      );
    }
    projects[nameProject] = newProject;
    return true;
  }
}
