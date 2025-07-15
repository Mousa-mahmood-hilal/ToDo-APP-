import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/presentation/widgets/custom_app_bar.dart';
import '../../logic/blocs/todo_cubit.dart';
import '../widgets/todo_tile.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<TodoCubit>().clearSelection(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar:  const CustomAppBar(title: "My Task"),
        body: BlocBuilder<TodoCubit, TodoState>(
          builder: (context, state) {
            if (state is TodoLoaded) {
              return ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    final todo = state.todos[index];
                    return TodoTile(
                      todo: state.todos[index],
                      index: index,
                      isSelected: state.selectedIndex == index,
                      onSelect: () => context.read<TodoCubit>().select(index),
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddTaskScreen(
                              existingTodo: todo,
                              index: index,
                            ),
                          ),
                        );
                      },
                      onDelete: () {
                        context.read<TodoCubit>().delete(index);
                        context.read<TodoCubit>().clearSelection();
                      },
                      onToggle: () => context.read<TodoCubit>().toggle(index),
                    );
                  });
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: FloatingActionButton(
            backgroundColor: Colors.transparent, // Make background transparent
            elevation: 0, // Remove shadow for better gradient look (optional)
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddTaskScreen()),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
