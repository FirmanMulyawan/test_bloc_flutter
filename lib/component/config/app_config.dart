import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final getIt = GetIt.instance;

final logger = Logger(
  // level: Level.all,
  // filter: CustomFilter(),
  level: kDebugMode ? Level.all : Level.warning,
  output: MultiOutput([
    ConsoleOutput(),
  ]),
);

/// required if you want to display logs in release mode
class CustomFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}
