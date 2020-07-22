import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:todo_list/todo_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange[800],
        brightness: Brightness.light,
      ),
      title: 'Todo List',
      home: TodoListScreen(),
    );
  }
}
