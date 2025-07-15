import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/presentation/widgets/gradient_text_field.dart';
import 'package:todo_app/presentation/widgets/custom_app_bar.dart';
import '../../../data/models/todo_model.dart';
import '../../logic/blocs/todo_cubit.dart';

class AddTaskScreen extends StatefulWidget {
  final ToDoModel? existingTodo; // if not null, it's editing
  final int? index; // needed to update

  const AddTaskScreen({super.key, this.existingTodo, this.index});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.existingTodo?.title ?? '');
    _descController =
        TextEditingController(text: widget.existingTodo?.description ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _handleSave() {
    final updatedTodo = ToDoModel(
      title: _titleController.text,
      description: _descController.text,
      date: widget.existingTodo?.date ?? DateTime.now(),
      isDone: widget.existingTodo?.isDone ?? false,
    );

    if (widget.existingTodo != null && widget.index != null) {
      // Edit existing task
      context.read<TodoCubit>().update(widget.index!, updatedTodo);
    } else {
      // Add new task
      context.read<TodoCubit>().add(updatedTodo);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingTodo != null;

    return Scaffold(
      appBar: CustomAppBar(
        title: (isEditing ? "Edit Task" : "New Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  GradientTextField(
                    controller: _titleController,
                    label: "Title",
                  ),
                  const SizedBox(height: 15),
                  GradientTextField(
                    controller: _descController,
                    label: "Description",
                    minLines: 1,
                    maxLines: 7,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.purple
                    ], // your gradient colors
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 20),
                  ),
                  onPressed: _handleSave,
                  child: Text(
                    isEditing ? "Save Changes" : "Add Task",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
