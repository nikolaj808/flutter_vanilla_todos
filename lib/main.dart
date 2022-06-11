import 'package:flutter/material.dart';
import 'package:flutter_vanilla_todos/app.dart';
import 'package:flutter_vanilla_todos/models/todo_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TodoAdapter());

  runApp(
    const App(),
  );
}
