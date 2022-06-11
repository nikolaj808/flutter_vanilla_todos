import 'package:flutter/material.dart';
import 'package:flutter_vanilla_todos/models/todo_model.dart';

class TodoListItem extends StatelessWidget {
  final Animation<double> animation;
  final int index;
  final Todo todo;
  final void Function(Todo changedTodo, bool isComplete) onTodoChanged;
  final void Function(int index, Todo deletedTodo) onTodoDelete;

  const TodoListItem({
    super.key,
    required this.animation,
    required this.index,
    required this.todo,
    required this.onTodoChanged,
    required this.onTodoDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: Dismissible(
          key: Key(todo.id.toString()),
          background: Container(color: Colors.red),
          onDismissed: (_) => onTodoDelete(index, todo),
          child: CheckboxListTile(
            value: todo.isComplete,
            title: Opacity(
              opacity: todo.isComplete ? 0.5 : 1.0,
              child: Text(
                todo.title,
                style: todo.isComplete
                    ? const TextStyle(
                        decoration: TextDecoration.lineThrough,
                      )
                    : null,
              ),
            ),
            secondary: const Icon(Icons.task_outlined),
            onChanged: (isComplete) => onTodoChanged(
              todo,
              isComplete ?? false,
            ),
          ),
        ),
      ),
    );
  }
}
