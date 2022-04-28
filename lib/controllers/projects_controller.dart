import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'file_controller.dart';
import '../view/dialogs_snackbars/my_snack_bar.dart';

import '../models/project.dart';
import '../others/logger.dart';

class ProjectsController extends GetxController {
  List<Project> projects = [];
  Duration scheduledTime = Duration();
  Project? currentProject;
  FileController fileController = Get.find();

  ProjectsController() {
    addTestProject();
  }
  bool newProject(String nameProject, String userName,
      {Duration scheduledTime = const Duration()}) {
    if (projects.any((element) => element.nameProject == nameProject)) {
      MySnackBar.warningSnackBar(
          'Colission project'.tr, 'There exists same name project'.tr);
      return false;
    }
    Project newProject = Project(nameProject: nameProject, user: userName);
    if (scheduledTime.inSeconds != 0) {
      newProject = Project(
        nameProject: nameProject,
        user: userName,
        scheduledTime: scheduledTime,
      );
    }
    projects.add(newProject);
    currentProject = newProject;

    fileController.saveProjects(listProjectsToJson(projects));
    return true;
  }

  bool existsNameProject(String newName) {
    return projects.any((element) => element.nameProject == newName);
  }

  addDurationToProject(Duration duration) {
    if (currentProject != null) {
      logger.d(
          'addDuration elapsedTime in seconds: ${currentProject!.elapsedTime.inSeconds}');
      currentProject!.elapsedTime += duration;
      logger.d(
          'addDuration elapsedTime in seconds: ${currentProject!.elapsedTime.inSeconds}');

      fileController.saveProjects(listProjectsToJson(projects));
    }
  }

  String listProjectsToJson(List<Project> listProject) {
    List<String> listJsonsProject = [];
    String jsonList = '';
    if (listProject.isNotEmpty) {
      for (Project project in listProject) {
        listJsonsProject.add(json.encode(project.toJson()));
      }
      jsonList = json.encode(listJsonsProject);
    }
    logger.d(jsonList);
    return jsonList;
  }

  List<Project> listProjectFromJson(String jsonString) {
    List<Project> listProjects = [];
    List<dynamic> listStringsProjects = json.decode(jsonString);
    if (listStringsProjects.isNotEmpty) {
      for (String stringProject in listStringsProjects) {
        listProjects.add(Project.fromJson(json.decode(stringProject)));
      }
    }
    return listProjects;
  }

  addTestProject() {
    Project testProject = Project(nameProject: 'Test project', user: 'me');
    testProject.scheduledTime = const Duration(minutes: 50);
    testProject.elapsedTime = const Duration(minutes: 10);
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
