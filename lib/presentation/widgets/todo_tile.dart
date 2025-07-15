import 'package:flutter/material.dart';
import '../../data/models/todo_model.dart';

class TodoTile extends StatelessWidget {
  final ToDoModel todo;
  final int index;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const TodoTile({
    super.key,
    required this.todo,
    required this.index,
    required this.isSelected,
    required this.onSelect,
    required this.onEdit,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: ListTile(
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(todo.description,
        style: TextStyle(
            decoration: todo.isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),),
        trailing: isSelected
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
