import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../models/project.dart';
import '../others/logger.dart';

class ProjectsController extends GetxController {
  List<Project> projects = [];
  Duration scheduledTime = Duration();
  Project? currentProject;

  ProjectsController() {
    addTestProject();
  }
  bool newProject(String nameProject, String ownerName,
      {Duration scheduledTime = const Duration()}) {
    if (projects.any((element) => element.nameProject == nameProject))
      return false;
    Project newProject = Project(nameProject: nameProject, owner: ownerName);
    if (scheduledTime.inSeconds != 0) {
      newProject = Project(
        nameProject: nameProject,
        owner: ownerName,
        scheduledTime: scheduledTime,
      );
    }
    projects.add(newProject);
    return true;
  }

  bool existsNameProject(String newName) {
    return projects.any((element) => element.nameProject == newName);
  }

  addTestProject() {
    Project testProject = Project(nameProject: 'Test project', owner: 'me');
    testProject.scheduledTime = Duration(minutes: 50);
    testProject.elapsedTime = Duration(minutes: 10);
    projects.add(testProject);
    currentProject = testProject;
  }

  bool setCurrentProjectByName(String nameProject) {
    projects.map((e) {
      if (e.nameProject == nameProject) {
        currentProject = e;
        return true;
      }
    });
    return false;
  }

  List<String> getListNamesProject() {
    return projects.map((e) => e.nameProject).toList();
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
