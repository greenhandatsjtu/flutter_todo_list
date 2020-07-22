import 'package:flutter/material.dart';
import 'package:todo_list/edit_todo_dialog.dart';
import 'package:todo_list/remove_confirm_dialog.dart';
import 'package:todo_list/todo.dart';

typedef ToggleTodoCallback = void Function(Todo, bool);
typedef RemoveTodoCallback = void Function(Todo);
typedef UpdateTodoCallback = void Function(Todo, String);

class TodoList extends StatelessWidget {
  TodoList(
      {@required this.todos,
      this.onTodoToggle,
      this.onRemoveTodo,
      this.onUpdateTodo});

  final List<Todo> todos;
  final ToggleTodoCallback onTodoToggle;
  final RemoveTodoCallback onRemoveTodo;
  final UpdateTodoCallback onUpdateTodo;

  Widget _buildItem(BuildContext context, int index) {
    final todo = todos[index];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: GestureDetector(
        onHorizontalDragEnd: (detail) async {
          final confirm = await showDialog(
              context: context,
              builder: (context) {
                return RemoveConfirmDialog(todo.title);
              });
          if (confirm != null) {
            onRemoveTodo(todo);
          }
        },
        onLongPress: () async {
          final newTitle = await showDialog(
              context: context,
              builder: (context) {
                return EditTodoDialog(
                  title: todo.title,
                );
              });
          if (newTitle != null && newTitle.toString() != todo.title) {
            onUpdateTodo(todo, newTitle);
          }
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: todo.isDone ? Colors.grey[200] : Colors.lime[200]),
          child: CheckboxListTile(
            value: todo.isDone,
            title: Text(todo.title,
                style: TextStyle(
                    color: todo.isDone ? Colors.grey[500] : null,
                    fontWeight: todo.isDone ? null : FontWeight.bold,
                    decoration:
                        todo.isDone ? TextDecoration.lineThrough : null)),
            onChanged: (bool isChecked) {
              onTodoToggle(todo, isChecked);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      itemBuilder: _buildItem,
      itemCount: todos.length,
    );
  }
}
