import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class ToDoModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  bool isDone;

  ToDoModel({
    required this.title,
    required this.description,
    required this.date,
    this.isDone = false,
  });
  ToDoModel copyWith({
    String? title,
    String? description,
    bool? isDone,
  }) {
    return ToDoModel(
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone, date: this.date,
    );
  }
}

