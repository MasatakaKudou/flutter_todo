import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: TodoList(title: 'Todo'),
    );
  }
}

class TodoList extends StatefulWidget {
  TodoList({Key key, this.title}) : super(key: key);
  final String title;
  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends State<TodoList> {

  List<String> todoItems = [];

  void newTodo() {
    setState(() {
      int index = todoItems.length;
      todoItems.add('Todo: ' + index.toString());
    });
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < todoItems.length) {
          return _buildTodoItem(todoItems[index]);
        }else{
          return _buildTodoItem("");
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText) {
    return new ListTile(
        title: new Text(todoText)
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text('Todo List')
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: newTodo,
          tooltip: 'Add task',
          child: new Icon(Icons.add)
      ),
    );
  }
}