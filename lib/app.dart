import 'package:flutter/material.dart';
import 'package:flutter_vanilla_todos/todos/todos_page.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Vanilla Todos',
      home: TodosPage(),
    );
  }
}
