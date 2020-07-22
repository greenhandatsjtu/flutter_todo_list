import 'package:flutter/material.dart';
import 'package:todo_list/todo.dart';

class NewTodoDialog extends StatelessWidget {
  final controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New todo'),
      content: TextField(
        controller: controller,
        autofocus: true,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          textColor: Colors.red,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Add'),
          textColor: Colors.green,
          onPressed: () {

            final todo = new Todo(title: controller.text);
            controller.clear();
            if(todo.title.length>0){
              Navigator.of(context).pop(todo);
            }else{
              Navigator.of(context).pop();
            }
          },
        )
      ],
    );
  }
}
