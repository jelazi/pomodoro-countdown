import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pomodoro_countdown/controllers/countdown_controller.dart';
import 'package:pomodoro_countdown/controllers/projects_controller.dart';
import 'package:pomodoro_countdown/view/dialogs_snackbars/my_snack_bar.dart';

import '../../models/project.dart';
import '../../others/logger.dart';

class CardProject extends StatefulWidget {
  Project project;
  var dataMap = <String, double>{};
  Function reload;
  CardProject(this.project, this.reload) {
    dataMap[project.nameProject] = project.elapsedTime.inMinutes.toDouble();
  }

  @override
  State<CardProject> createState() => _CardProjectState();
}

class _CardProjectState extends State<CardProject> {
  final ProjectsController _projectsController = Get.find();
  final colorList = <Color>[
    Colors.grey,
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: openProject,
      child: Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.blue),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          setState(() {
            _projectsController.deleteProject(widget.project.id);
            widget.reload();
            MySnackBar.warningSnackBar('Deleting project',
                'Project ${widget.project.nameProject} is deleted.');
          });
        },
        child: Card(
          elevation: 50,
          color: Colors.red,
          child: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.project.nameProject,
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.project.totalTime.inMinutes.toString() +
                              'minutes'.tr,
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 100,
                    child: PieChart(
                      ringStrokeWidth: 15,
                      dataMap: widget.dataMap,
                      chartType: ChartType.ring,
                      baseChartColor: Colors.white,
                      colorList: colorList,
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValuesInPercentage: true,
                      ),
                      emptyColor: Colors.white,
                      totalValue: widget.project.totalTime.inMinutes.toDouble(),
                      legendOptions: const LegendOptions(
                          showLegends: false,
                          legendTextStyle: TextStyle(color: Colors.white),
                          legendPosition: LegendPosition.bottom),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  openProject() {
    ProjectsController projectsController = Get.find();
    projectsController.selectProject(widget.project);
    CountDownController countDownController = Get.find();
    countDownController.resetValues();
    countDownController.currentRoundNumber.value = 0;
    countDownController.controller.value = 0;
    logger.d(projectsController.currentProject?.nameProject ?? '');
    Navigator.of(Get.overlayContext!).pop();
  }
}
