import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pomodoro_countdown/view/screens/projects_screen.dart';
import '../../controllers/settings_controller.dart';

import '../screens/add_project.dart';
import '../../controllers/projects_controller.dart';
import '../screens/new_user_dialog.dart';
import '../screens/settings_screen.dart';

class PomodoroDrawer extends StatefulWidget {
  PomodoroDrawer() {
    dataMap[_projectsController.currentProjectName.value] =
        _projectsController.currentProjectElaspsedValue.value;
  }
  final ProjectsController _projectsController = Get.find();

  var dataMap = <String, double>{};

  @override
  State<PomodoroDrawer> createState() => _PomodoroDrawerState();
}

class _PomodoroDrawerState extends State<PomodoroDrawer> {
  final SettingsController _settingsController = Get.find();
  final colorList = <Color>[
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black87,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,

        children: [
          DrawerHeader(
            decoration: const BoxDecoration(),
            child: Stack(
              children: [
                Obx(
                  () => Visibility(
                    visible: _settingsController.logIn.value,
                    child: Center(
                      child: SizedBox(
                        height: 300,
                        width: 300,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100,
                              child: PieChart(
                                ringStrokeWidth: 15,
                                dataMap: widget.dataMap,
                                chartType: ChartType.ring,
                                baseChartColor: Colors.grey,
                                colorList: colorList,
                                chartValuesOptions: const ChartValuesOptions(
                                  showChartValuesInPercentage: true,
                                ),
                                emptyColor: Colors.white,
                                totalValue: widget._projectsController
                                    .currentProjectTotalValue.value,
                                legendOptions: const LegendOptions(
                                    showLegends: false,
                                    legendTextStyle:
                                        TextStyle(color: Colors.white),
                                    legendPosition: LegendPosition.bottom),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 8.0,
                                top: 10,
                              ),
                              child: Text(
                                widget._projectsController.currentProjectName
                                    .value,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !_settingsController.logIn.value,
                  child: const Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image(
                        image: AssetImage('assets/icons/tomatoDone.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _settingsController.isCurrentUserAdmin.value,
            child: ListTile(
              tileColor: Colors.white24,
              title: Text(
                'addUser'.tr,
                style: const TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
                Get.dialog(NewUserDialog());
              },
            ),
          ),
          Visibility(
            visible: _settingsController.logIn.value,
            child: ListTile(
              tileColor: Colors.white24,
              title: Text(
                'addProject'.tr,
                style: const TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
                Get.dialog(AddProject());
              },
            ),
          ),
          Visibility(
            visible: _settingsController.logIn.value,
            child: ListTile(
              tileColor: Colors.white24,
              title: Text(
                'selectProject'.tr,
                style: const TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.edit_location,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
                Get.to(ProjectsScreen());
              },
            ),
          ),
          ListTile(
            tileColor: Colors.white24,
            title: Text('openSettings'.tr,
                style: const TextStyle(color: Colors.white)),
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
          ListTile(
            tileColor: Colors.white24,
            title: Text('sync'.tr, style: const TextStyle(color: Colors.white)),
            leading: const Icon(
              Icons.sync,
              color: Colors.white,
            ),
            onTap: () {
              // TODO:Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
