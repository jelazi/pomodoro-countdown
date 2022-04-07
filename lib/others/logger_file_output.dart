import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class LoggerFileOutput extends LogOutput {
  LoggerFileOutput();

  File? file;

  @override
  void init() async {
    _createFile();
    super.init();
  }

  Future<String> get _getDirPath async {
    final dirExternal = await getExternalStorageDirectory();
    final dir = await getApplicationDocumentsDirectory();
    return dirExternal?.path ?? dir.path;
  }

  Future<void> _createFile() async {
    final _dirPath = await _getDirPath;
    if (await File('$_dirPath/log.txt').exists()) {
      file = File('$_dirPath/log.txt');
    } else {
      file = await File('$_dirPath/log.txt').create(recursive: true);
    }
  }

  @override
  void output(OutputEvent event) async {
    if (file != null) {
      for (var line in event.lines) {
        await file?.writeAsString("${line.toString()}\n",
            mode: FileMode.writeOnlyAppend);
      }
    } else {
      for (var line in event.lines) {
        print(line);
      }
    }
  }
}
