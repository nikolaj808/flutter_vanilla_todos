import 'package:flutter_vanilla_todos/models/todo_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

class TodosRepository {
  static const String todosBoxName = 'todosBox';

  const TodosRepository();

  static Future<Stream<BoxEvent>> getTodosStream() async {
    final box = await Hive.openBox<Todo>(todosBoxName);

    return box.watch();
  }

  static Future<List<Todo>> getTodos() async {
    final box = await Hive.openBox<Todo>(todosBoxName);

    final todos = box.values.toList();

    return todos;
  }

  static Future<Todo> getTodoById(String todoId) async {
    final box = await Hive.openBox<Todo>(todosBoxName);

    final todo = box.get(todoId);

    if (todo == null) {
      throw Exception('Did not find a todo with that id');
    }

    return todo;
  }

  static Future<Todo> createTodo(String todoTitle) async {
    final box = await Hive.openBox<Todo>(todosBoxName);

    final createdTodo = Todo(
      id: const Uuid().v4(),
      title: todoTitle,
    );

    await box.put(createdTodo.id, createdTodo);

    return createdTodo;
  }

  static Future<Todo> updateTodo(Todo updatedTodo) async {
    final box = await Hive.openBox<Todo>(todosBoxName);

    await box.put(updatedTodo.id, updatedTodo);

    return updatedTodo;
  }

  static Future<void> deleteTodo(String todoId) async {
    final box = await Hive.openBox<Todo>(todosBoxName);

    return box.delete(todoId);
  }
}
