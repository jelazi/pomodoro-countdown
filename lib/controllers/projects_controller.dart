import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../models/project.dart';
import '../others/logger.dart';

class ProjectsController extends GetxController {
  Map<String, Project> projects = {};
  Duration scheduledTime = Duration();
  Project? currentProject;

  ProjectsController() {
    addTestProject();
  }
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

  addTestProject() {
    Project testProject = Project(nameProject: 'Test project', owner: 'me');
    testProject.scheduledTime = Duration(minutes: 50);
    testProject.elapsedTime = Duration(minutes: 10);
    projects[testProject.nameProject] = testProject;
    currentProject = testProject;
  }

  RxString get currentProjectName {
    if (currentProject != null) {
      return ('project'.tr + currentProject!.nameProject).obs;
    }
    String emptyProject = 'emptyProject'.tr;
    return RxString(emptyProject);
  }

  RxDouble get currentProjectTotalValue {
    if (currentProject != null) {
      return (currentProject!.scheduledTime.inMinutes.toDouble()).obs;
    }
    return 20.0.obs;
  }

  RxDouble get currentProjectElaspsedValue {
    if (currentProject != null) {
      return (currentProject!.elapsedTime.inMinutes.toDouble()).obs;
    }
    return 0.0.obs;
  }
}
