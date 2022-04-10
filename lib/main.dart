import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pomodoro_countdown/controllers/countdown_controller.dart';
import 'package:pomodoro_countdown/controllers/file_controller.dart';
import 'package:pomodoro_countdown/controllers/projects_controller.dart';
import 'package:pomodoro_countdown/controllers/ring_controlller.dart';
import 'package:pomodoro_countdown/controllers/settings_controller.dart';
import 'package:pomodoro_countdown/view/items/pomodoro_drawer.dart';
import 'package:pomodoro_countdown/view/screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  final FileController _fileController = Get.put(FileController());
  final SettingsController _settingsController = Get.put(SettingsController());
  final RingController _ringController = Get.put(RingController());
  final CountDownController _countDownController =
      Get.put(CountDownController());
  final ProjectsController _projectControlller = Get.put(ProjectsController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  final String title = 'Pomodoro countdown';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: PomodoroDrawer(),
      body: MainScreen(),
    );
  }
}
