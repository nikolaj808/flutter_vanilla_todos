import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_vanilla_todos/models/todo_model.dart';
import 'package:flutter_vanilla_todos/repositories/todos_repository.dart';
import 'package:flutter_vanilla_todos/todos/widgets/todos_form_widget.dart';
import 'package:flutter_vanilla_todos/todos/widgets/todos_list_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodosPage extends StatefulWidget {
  final List<Todo> initialTodos;

  const TodosPage({
    super.key,
    required this.initialTodos,
  });

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  static final GlobalKey<AnimatedListState> animatedListKey =
      GlobalKey<AnimatedListState>();

  final TextEditingController todosController = TextEditingController();

  late List<Todo> todos;

  StreamSubscription<BoxEvent>? todosBoxEventStreamSubscription;

  @override
  void initState() {
    super.initState();

    todos = widget.initialTodos;

    initializeTodosStreamHandler();
  }

  Future<void> initializeTodosStreamHandler() async {
    final todosBoxEventStream = await TodosRepository.getTodosStream();

    todosBoxEventStreamSubscription =
        todosBoxEventStream.listen((todosBoxEvent) {
      final todoId = todosBoxEvent.key as String;
      final updatedTodo = todosBoxEvent.value as Todo?;

      if (updatedTodo == null) {
        return;
      }

      if (todos.any((todo) => todo.id == todoId)) {
        setState(
          () => todos = todos
              .map((todo) => todo.id == todoId ? updatedTodo : todo)
              .toList(),
        );

        return;
      }

      animatedListKey.currentState!.insertItem(
        todos.length,
      );

      setState(() => todos = [...todos, updatedTodo]);
    });
  }

  @override
  void dispose() {
    todosBoxEventStreamSubscription?.cancel();

    todosController.dispose();

    super.dispose();
  }

  void onNewTodoSubmit(String title) {
    TodosRepository.createTodo(title);

    todosController.clear();
  }

  void onTodoChanged(Todo changedTodo, bool isComplete) {
    TodosRepository.updateTodo(changedTodo.toggleComplete());
  }

  void onTodoDelete(int index, Todo deletedTodo) {
    TodosRepository.deleteTodo(deletedTodo.id);

    setState(
      () => todos = todos.where((todo) => todo.id != deletedTodo.id).toList(),
    );

    animatedListKey.currentState!.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: Container(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Todos',
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              TodosForm(
                todosController: todosController,
                onNewTodoSubmit: onNewTodoSubmit,
              ),
              Expanded(
                child: TodosList(
                  animatedListKey: animatedListKey,
                  todos: todos,
                  onTodoChanged: onTodoChanged,
                  onTodoDelete: onTodoDelete,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
