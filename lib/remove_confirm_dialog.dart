import 'package:flutter/material.dart';

class RemoveConfirmDialog extends StatelessWidget {
  RemoveConfirmDialog(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirm remove: \"$title\""),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          textColor: Colors.grey,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Remove'),
          textColor: Colors.red,
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        )
      ],
    );
  }
}
