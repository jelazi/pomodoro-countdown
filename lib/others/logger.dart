import 'package:logger/logger.dart';
import 'logger_file_output.dart';

Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    noBoxingByDefault: true,
  ),
  //output: LoggerFileOutput(),
);
