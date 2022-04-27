import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

class FileController extends GetxController {
  final box = GetStorage();
  saveProjects(String jsonProjects) {
    box.write('projects', jsonProjects);
  }

  String? getProject() {
    return box.read('projects');
  }

  saveOwners(String jsonOwners) {
    box.write('owners', jsonOwners);
  }

  String? getOwners() {
    return box.read('owners');
  }
}
