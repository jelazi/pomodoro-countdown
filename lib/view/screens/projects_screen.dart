import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/projects_controller.dart';
import '../../controllers/settings_controller.dart';
import '../items/card_project.dart';

import '../../models/project.dart';

class ProjectsScreen extends StatefulWidget {
  SettingsController _settingsController = Get.find();
  ProjectsController _projectsController = Get.find();
  ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: Text('selectProjectTitle'.tr),
      ),
      body: Container(
        child: widget._projectsController
                .getListByUser(
                    widget._settingsController.currentUser?.name ?? '')
                .isEmpty
            ? const Center(
                child: Text(
                'There is not Project for current users',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ))
            : ListView.builder(
                itemCount: widget._projectsController
                    .getListByUser(
                        widget._settingsController.currentUser?.name ?? '')
                    .length,
                itemBuilder: (context, index) {
                  return CardProject(widget._projectsController.getListByUser(
                      widget._settingsController.currentUser?.name ??
                          '')[index]);
                },
              ),
      ),
    );
  }
}
