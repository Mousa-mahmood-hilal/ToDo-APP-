import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/todo_model.dart';
import '../../../data/sources/local_data_source.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final LocalDataSource localDataSource;
  int? selectedIndex;
  TodoCubit(this.localDataSource) : super(TodoInitial()) {
    loadTodos();
  }

  void loadTodos() {
    final todos = localDataSource.getTodos();
    emit(TodoLoaded(todos, selectedIndex:null));
  }

  void add(ToDoModel todo) {
    localDataSource.addTodo(todo);
    selectedIndex = null;
    loadTodos();
  }

  void delete(int index) {
    localDataSource.deleteTodo(index);
    selectedIndex = null;
    loadTodos();
  }

  void toggle(int index) async {
    await localDataSource.toggleStatus(index);
    loadTodos();
  }

  void select(int index) {
    if (state is TodoLoaded) {
      final current = state as TodoLoaded;
      emit(current.copyWith(selectedIndex: current.selectedIndex == index ? null : index));
    }
  }

  void clearSelection() {
    if (state is TodoLoaded) {
      final current = state as TodoLoaded;
      emit(current.copyWith(selectedIndex: null));
    }
  }
  void selectIndex(int? index) {
    selectedIndex = index;
    loadTodos();
  }
  void update(int index, ToDoModel updatedTodo) {
  localDataSource.updateTodo(index, updatedTodo);
  loadTodos();
}
}

