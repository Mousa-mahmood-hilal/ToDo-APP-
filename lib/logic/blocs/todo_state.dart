part of 'todo_cubit.dart';

abstract class TodoState extends Equatable {
  const TodoState();
  @override
  List<Object?> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoaded extends TodoState {
  final List<ToDoModel> todos;
  final int? selectedIndex;
   const TodoLoaded(this.todos, {this.selectedIndex});
  TodoLoaded copyWith({List<ToDoModel>? todos, int? selectedIndex}) {
    return TodoLoaded(
      todos ?? this.todos,
      selectedIndex: selectedIndex,
    );
  }
  @override
  List<Object?> get props => [todos,selectedIndex];
}
