import 'package:flutter/material.dart';

class TodosForm extends StatelessWidget {
  final TextEditingController todosController;
  final void Function(String title) onNewTodoSubmit;

  const TodosForm({
    super.key,
    required this.todosController,
    required this.onNewTodoSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8.0,
      ),
      child: Align(
        child: TextField(
          controller: todosController,
          onSubmitted: onNewTodoSubmit,
          decoration: const InputDecoration(
            hintText: 'What do you need to do?',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
