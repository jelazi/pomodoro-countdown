import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_countdown/models/user.dart';

import '../../controllers/settings_controller.dart';
import '../dialogs_snackbars/my_snack_bar.dart';

class NewUserDialog extends StatefulWidget {
  const NewUserDialog({Key? key}) : super(key: key);

  @override
  State<NewUserDialog> createState() => _NewUserDialogState();
}

class _NewUserDialogState extends State<NewUserDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final SettingsController _settingsController = Get.find();
  String name = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      insetPadding: EdgeInsets.zero,
      shape:
          const RoundedRectangleBorder(side: BorderSide(color: Colors.white)),
      content: SizedBox(
        height: 250,
        width: 300,
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
                      'nameUser'.tr,
                      style: const TextStyle(color: Colors.white),
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
                      'passUser'.tr,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: passwordController,
                      onChanged: (value) {
                        setState(() {
                          password = value;
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
                          borderSide: BorderSide(color: Colors.white),
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
                          borderSide: BorderSide(color: Colors.grey),
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
                    onPressed: addUser,
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

  addUser() {
    Navigator.of(Get.overlayContext!).pop();
    User user = User(name, password);
    if (_settingsController.addNewUser(user)) {
      MySnackBar.warningSnackBar(
          'newUser'.tr, 'newUser'.tr + ': ' + name + 'created'.tr);
    } else {
      MySnackBar.warningSnackBar(
          'newUser'.tr, 'newUser'.tr + ': ' + name + 'hasSameName'.tr);
    }
  }

  cancel() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
