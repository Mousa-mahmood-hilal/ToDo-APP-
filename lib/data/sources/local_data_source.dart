import 'package:hive/hive.dart';
import '../models/todo_model.dart';

class LocalDataSource {
  final Box<ToDoModel> todoBox = Hive.box<ToDoModel>('todos');

  List<ToDoModel> getTodos() {
  final box = Hive.box<ToDoModel>('todos');
  return box.values.map((e) => e.copyWith()).toList(); 
}

  void addTodo(ToDoModel todo) => todoBox.add(todo);

  void updateTodo(int index, ToDoModel updated) => todoBox.putAt(index, updated);

  void deleteTodo(int index) => todoBox.deleteAt(index);

Future<void> toggleStatus(int index) async {
  final box = Hive.box<ToDoModel>('todos');
  final todo = box.getAt(index);
  if (todo != null) {
    todo.isDone = !todo.isDone;
    await todo.save(); 
  }
}


}
