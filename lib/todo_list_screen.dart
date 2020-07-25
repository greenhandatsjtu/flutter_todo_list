import 'package:flutter/material.dart';
import 'package:todo_list/add_todo_dialog.dart';
import 'package:todo_list/todo.dart';
import 'package:todo_list/todo_list.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [];
  final todoProvider = TodoProvider();

  Future initDb() async {
    await todoProvider.open("todo.db");
  }

  _addTodo(Todo todo) async {
    await todoProvider.insert(todo);
    setState(() {
      todos.add(todo);
    });
  }

  _toggleTodo(Todo todo, bool isChecked) async {
    todo.isDone = isChecked;
    await todoProvider.update(todo);
    setState(() {
      todo.isDone = isChecked;
    });
  }

  _removeTodo(Todo todo) async {
    await todoProvider.delete(todo.id);
    setState(() {
      todos.remove(todo);
    });
  }

  _updateTodo(Todo todo, String newTitle) async {
    todo.title = newTitle;
    await todoProvider.update(todo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        leading: FlutterLogo(),
        title: Text('Todo List'),
      ),
      body: TodoList(
        todos: todos,
        onTodoToggle: _toggleTodo,
        onRemoveTodo: _removeTodo,
        onUpdateTodo: _updateTodo,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        elevation: 20,
        color: Colors.white,
        notchMargin: 4,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.today, semanticLabel: "Today"),
              onPressed: () => {},
            ),
            SizedBox(),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        tooltip: 'Add to-do',
        onPressed: () async {
          final todo = await showDialog<Todo>(
              context: context,
              builder: (BuildContext context) {
                return NewTodoDialog();
              });
          if (todo != null) {
            _addTodo(todo);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void initState() {
    super.initState();
    initDb().then((value) => todoProvider.getTodos().then((value) {
          todos = value;
          setState(() {});
        }));
  }
}
