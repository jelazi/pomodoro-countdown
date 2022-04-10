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
            decoration: BoxDecoration(),
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
