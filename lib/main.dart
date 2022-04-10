import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pomodoro_countdown/controllers/countdown_controller.dart';
import 'package:pomodoro_countdown/controllers/file_controller.dart';
import 'package:pomodoro_countdown/controllers/projects_controller.dart';
import 'package:pomodoro_countdown/controllers/ring_controlller.dart';
import 'package:pomodoro_countdown/controllers/settings_controller.dart';
import 'package:pomodoro_countdown/view/items/pomodoro_drawer.dart';
import 'package:pomodoro_countdown/view/screens/main_screen.dart';

import 'others/languages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await GetStorage.init();
  final FileController _fileController = Get.put(FileController());
  final SettingsController _settingsController = Get.put(SettingsController());
  final RingController _ringController = Get.put(RingController());
  final CountDownController _countDownController =
      Get.put(CountDownController());
  final ProjectsController _projectControlller = Get.put(ProjectsController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SettingsController _settingsController = Get.find();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      translations: Languages(),
      locale: _settingsController.language,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Pomodoro countdown'.tr),
      ),
      drawer: PomodoroDrawer(),
      body: MainScreen(),
    );
  }
}
