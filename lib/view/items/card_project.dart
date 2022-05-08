import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pomodoro_countdown/view/dialogs_snackbars/question_dialog.dart';
import '../../controllers/countdown_controller.dart';
import '../../controllers/projects_controller.dart';
import '../dialogs_snackbars/my_snack_bar.dart';

import '../../models/project.dart';
import '../../others/logger.dart';

class CardProject extends StatefulWidget {
  final Project project;
  final dataMap = <String, double>{};
  final Function reload;
  CardProject(this.project, this.reload, {Key? key}) : super(key: key) {
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
        background: Container(
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: 20.0,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 50,
                ),
                onPressed: null,
              ),
            ),
          ),
        ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (DismissDirection direction) async {
          deleteProjectDialog();
        },
        child: Card(
          elevation: 50,
          color: const Color.fromARGB(255, 17, 89, 177),
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
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.project.totalTime.inMinutes.toString() +
                                    'minutes'.tr,
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'remain'.tr +
                                    (widget.project.totalTime.inMinutes -
                                            widget
                                                .project.elapsedTime.inMinutes)
                                        .toString() +
                                    'minutes'.tr,
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
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

  deleteProjectDialog() {
    Get.dialog(QuestionDialog('deleteProject'.tr, 'questionDeleteProject'.tr,
        'yes'.tr, 'no'.tr, deleteProject));
  }

  deleteProject() async {
    setState(() {
      _projectsController.deleteProject(widget.project.id);
      widget.reload();
      MySnackBar.warningSnackBar('Deleting project',
          'Project ${widget.project.nameProject} is deleted.');
    });
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
