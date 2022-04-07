import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_countdown/view/screens/settings_screen.dart';

class PomodoroDrawer extends StatefulWidget {
  PomodoroDrawer({Key? key}) : super(key: key);

  @override
  State<PomodoroDrawer> createState() => _PomodoroDrawerState();
}

class _PomodoroDrawerState extends State<PomodoroDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text('Pomodoro drawer'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(),
          ),
          ListTile(
            title: Text('openSettings'.tr),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()));

              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('sync'.tr),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
