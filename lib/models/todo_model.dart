import 'package:hive_flutter/hive_flutter.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool isComplete;

  @HiveField(3)
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    this.isComplete = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Todo toggleComplete() {
    return Todo(
      id: id,
      title: title,
      isComplete: !isComplete,
      createdAt: createdAt,
    );
  }
}
