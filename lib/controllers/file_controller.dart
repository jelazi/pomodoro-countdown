import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

class FileController extends GetxController {
  final box = GetStorage();
  saveProjects(String jsonProjects) {
    box.write('projects', jsonProjects);
  }

  String? getProjects() {
    return box.read('projects');
  }

  saveUsers(List<String> jsonUsers) {
    box.write('users', jsonUsers);
  }

  List<String>? getUsers() {
    return box.read('users');
  }
}
