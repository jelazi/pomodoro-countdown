import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'file_controller.dart';
import '../view/dialogs_snackbars/my_snack_bar.dart';

import '../models/project.dart';
import '../others/logger.dart';
import 'settings_controller.dart';

class ProjectsController extends GetxController {
  List<Project> projects = [];
  Duration scheduledTime = Duration();
  Project? currentProject;
  final FileController _fileController = Get.find();
  final SettingsController _settingsController = Get.find();
  RxString currentProjectName = RxString('');
  RxDouble currentProjectTotalValue = RxDouble(0);
  RxDouble currentProjectElaspsedValue = RxDouble(0);
  var dataMapPieChart = <String, double>{}.obs;

  ProjectsController() {
    //  addTestProject();

    loadProjects();
  }

  loadProjects() {
    String? jsonProject = _fileController.getProjects();
    if (jsonProject != null && jsonProject.isNotEmpty) {
      projects = listProjectFromJson(jsonProject);
    }
    if (_settingsController.currentUser != null) {
      List<Project> listProjectUser =
          getListByUser(_settingsController.currentUser?.name ?? '');
      if (listProjectUser.isNotEmpty) {
        selectProject(listProjectUser.first);
      }
    }
  }

  bool deleteProject(String idProject) {
    logger.d(idProject);
    if (currentProject?.id == idProject) {
      currentProject = null;
      currentProjectName.value = '';
      currentProjectTotalValue.value = 0;
      currentProjectElaspsedValue.value = 0;
    }
    if (!projects.any((element) => element.id == idProject)) return false;
    projects.removeWhere((element) => element.id == idProject);
    _fileController.saveProjects(listProjectsToJson(projects));
    return true;
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
        totalTime: scheduledTime,
      );
    }
    projects.add(newProject);
    selectProject(newProject);

    _fileController.saveProjects(listProjectsToJson(projects));
    return true;
  }

  selectProject(Project project) {
    currentProject = project;
    currentProjectName.value = project.nameProject;
    currentProjectElaspsedValue.value =
        project.elapsedTime.inMinutes.toDouble();
    currentProjectTotalValue.value = project.totalTime.inMinutes.toDouble();
    dataMapPieChart['elapsed'] = project.elapsedTime.inMinutes.toDouble();
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
      MySnackBar.warningSnackBar(
          'addDurationTitle'.tr,
          'addDuration1'.tr +
              duration.inMinutes.toString() +
              'addDuration2'.tr);
      _fileController.saveProjects(listProjectsToJson(projects));
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
    Project testProject = Project(nameProject: 'Test project', user: 'admin');
    testProject.totalTime = const Duration(minutes: 50);
    testProject.elapsedTime = const Duration(minutes: 10);
    projects.add(testProject);
    Project test2Project = Project(nameProject: 'Test project2', user: 'admin');
    test2Project.totalTime = const Duration(minutes: 80);
    test2Project.elapsedTime = const Duration(minutes: 70);
    projects.add(test2Project);
    selectProject(testProject);
  }

  bool setCurrentProjectByName(String nameProject) {
    projects.map((e) {
      if (e.nameProject == nameProject) {
        selectProject(e);
        return true;
      }
    });
    return false;
  }

  List<String> getListNamesProject() {
    return projects.map((e) => e.nameProject).toList();
  }

  List<Project> getListByUser(String nameUser) {
    List<Project> projectByUser = [];
    for (Project project in projects) {
      if (project.user == nameUser) {
        projectByUser.add(project);
      }
    }
    return projectByUser;
  }
}
