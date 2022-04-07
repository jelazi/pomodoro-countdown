import 'package:get/get.dart';

class SettingsController extends GetxController {
  SettingsController() {}
  RxInt rounds = RxInt(3);
  RxInt secondsWork = RxInt(45 * 60);
  RxInt secondsBreak = RxInt(10 * 60);
  RxInt secondsBreakAfterRound = RxInt(20 * 60);
  RxString nameOwner = RxString('');
  RxString passwordOwner = RxString('');
}
