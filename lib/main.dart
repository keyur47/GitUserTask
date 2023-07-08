import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/task.dart';

import 'helper/db_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await initDatabase;
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const Task());
}
