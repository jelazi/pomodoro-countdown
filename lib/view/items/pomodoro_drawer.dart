import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../controllers/projects_controller.dart';
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
  final colorList = <Color>[
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(),
            child: Stack(
              children: [
                Visibility(
                  visible: widget._projectsController.currentProject != null,
                  child: Center(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: PieChart(
                        ringStrokeWidth: 15,
                        dataMap: widget.dataMap,
                        chartType: ChartType.ring,
                        baseChartColor: Colors.grey,
                        colorList: colorList,
                        chartValuesOptions: ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
                        emptyColor: Colors.black,
                        totalValue: widget
                            ._projectsController.currentProjectTotalValue.value,
                        legendOptions: LegendOptions(
                            legendPosition: LegendPosition.bottom),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget._projectsController.currentProject == null,
                  child: Center(
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
          ListTile(
            title: Text('addProject'.tr),
            leading: const Icon(Icons.add),
            onTap: () {
              Navigator.pop(context);
              if (widget._projectsController.currentProject == null) {}
            },
          ),
          ListTile(
            title: Text('openSettings'.tr),
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
          ListTile(
            title: Text('sync'.tr),
            leading: const Icon(Icons.sync),
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
