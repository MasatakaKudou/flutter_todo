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

  void newTodo(String task) {
    if (task.length > 0) {
      setState(() => todoItems.add(task));
    }
  }

  void _pushAddToScreen() {
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
                  appBar: new AppBar(
                      title: new Text('Add a new task')
                  ),
                  body: new TextField(
                    autofocus: true,
                    onSubmitted: (val) {
                      newTodo(val);
                      Navigator.pop(context);
                    },
                    decoration: new InputDecoration(
                        hintText: 'input new todo',
                        contentPadding: const EdgeInsets.all(16.0)
                    ),
                  )
              );
            }
        )
    );
  }

  void removeTodo(int index){
    setState(() => todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text( todoItems[index] + ' is done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()
                ),
                new FlatButton(
                    child: new Text('DONE'),
                    onPressed: () {
                      removeTodo(index);
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < todoItems.length) {
          return _buildTodoItem(todoItems[index], index);
        } else {
          return _buildTodoItem("", 0);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText,int index) {
    return new Card(
        child: ListTile(
            title: new Text(todoText),
            subtitle: Text('Here is a second line'),
            trailing: Icon(Icons.more_vert),
          onTap: () => _promptRemoveTodoItem(index)
        ),
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
          onPressed: _pushAddToScreen,
          tooltip: 'Add task',
          child: new Icon(Icons.add)
      ),
    );
  }

}