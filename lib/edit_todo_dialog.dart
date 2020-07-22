import 'package:flutter/material.dart';

class EditTodoDialog extends StatelessWidget {
  final controller = new TextEditingController();

  EditTodoDialog({Key key, @required String title}) : super(key: key) {
    print(title);
    controller.text = title;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit todo'),
      content: TextField(
        controller: controller,
        autofocus: true,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          textColor: Colors.grey,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Save'),
          textColor: Colors.blue,
          onPressed: () {
            Navigator.of(context).pop(controller.text.length>0?controller.text:null);
          },
        )
      ],
    );
  }
}
