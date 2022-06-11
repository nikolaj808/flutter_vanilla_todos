import 'package:flutter/material.dart';
import 'package:flutter_vanilla_todos/models/todo_model.dart';
import 'package:flutter_vanilla_todos/todos/widgets/todo_list_item_widget.dart';

class TodosList extends StatelessWidget {
  final GlobalKey<AnimatedListState> animatedListKey;
  final List<Todo> todos;
  final void Function(Todo changedTodo, bool isComplete) onTodoChanged;
  final void Function(int index, Todo deletedTodo) onTodoDelete;

  const TodosList({
    super.key,
    required this.animatedListKey,
    required this.todos,
    required this.onTodoChanged,
    required this.onTodoDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: animatedListKey,
      initialItemCount: todos.length,
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      itemBuilder: (context, index, animation) {
        final todo = todos.elementAt(index);

        return TodoListItem(
          animation: animation,
          index: index,
          todo: todo,
          onTodoChanged: onTodoChanged,
          onTodoDelete: onTodoDelete,
        );
      },
    );
  }
}
