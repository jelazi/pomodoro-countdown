import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/projects_controller.dart';
import '../../controllers/settings_controller.dart';
import '../items/card_project.dart';
import 'add_project.dart';

class ProjectsScreen extends StatefulWidget {
  final SettingsController _settingsController = Get.find();
  final ProjectsController _projectsController = Get.find();
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            Get.dialog(const AddProject());
          });
        },
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
            : Obx(
                (() => ListView.builder(
                      itemCount: widget._projectsController
                          .getListByUser(
                              widget._settingsController.currentUser?.name ??
                                  '')
                          .length,
                      itemBuilder: (context, index) {
                        return CardProject(
                            widget._projectsController.getListByUser(
                                widget._settingsController.currentUser?.name ??
                                    '')[index],
                            reload);
                      },
                    )),
              ),
      ),
    );
  }

  reload() {
    setState(() {});
  }
}
