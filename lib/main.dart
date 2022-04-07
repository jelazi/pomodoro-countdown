import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_countdown/controllers/countdown_controller.dart';
import 'package:pomodoro_countdown/controllers/file_controller.dart';
import 'package:pomodoro_countdown/controllers/settings_controller.dart';
import 'package:pomodoro_countdown/view/items/pomodoro_drawer.dart';
import 'package:pomodoro_countdown/view/screens/main_screen.dart';

void main() {
  final SettingsController _settingsController = Get.put(SettingsController());
  final CountDownController _countDownController =
      Get.put(CountDownController());
  final FileController _fileController = Get.put(FileController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
