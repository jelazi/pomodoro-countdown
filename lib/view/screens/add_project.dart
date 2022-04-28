import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/projects_controller.dart';
import '../../controllers/settings_controller.dart';
import '../dialogs_snackbars/my_snack_bar.dart';

class AddProject extends StatefulWidget {
  AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  TextEditingController nameController = TextEditingController();
  TextEditingController scheduledTimeController = TextEditingController();
  final ProjectsController _projectsController = Get.find();
  final SettingsController _settingsController = Get.find();

  String name = '';
  int durationMinutes = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white)),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'nameProject'.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'scheduledTime'.tr,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: scheduledTimeController,
                      keyboardType:
                          const TextInputType.numberWithOptions(signed: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        int? val = int.tryParse(value);
                        if (val != null && val > 0) {
                          durationMinutes = val;
                        }
                      },
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: addProject,
                    child: Text('add'.tr),
                  ),
                  ElevatedButton(
                    onPressed: cancel,
                    child: Text('cancel'.tr),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  addProject() {
    Duration duration = Duration();
    if (durationMinutes > 45) {
      duration = Duration(minutes: durationMinutes);
    } else {
      MySnackBar.warningSnackBar(
          'tooSmall'.tr, 'This duration is too short.'.tr);
      return;
    }
    String nameProject = name;
    if (_projectsController.existsNameProject(nameProject)) {
      MySnackBar.warningSnackBar(
          'sameName'.tr, 'There is same name project.'.tr);
      return;
    }
    _projectsController.newProject(
        nameProject, _settingsController.currentUser?.name ?? '',
        scheduledTime: duration);
    Navigator.of(Get.overlayContext!).pop();
    MySnackBar.warningSnackBar(
        'newProject'.tr, 'Project $nameProject  created.'.tr);
  }

  cancel() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
