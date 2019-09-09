import 'package:flutter/material.dart';
import 'dart:async';

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

  final _todo = <Task>[];

  void _removeTodoItem(Task task) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text( task.title + ' is done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()
                ),
                new FlatButton(
                    child: new Text('DONE'),
                    onPressed: () {
                      setState(() => _todo.remove(task));
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemBuilder: (context, i) {
        return _buildTask(_todo[i]);
        },
      itemCount: _todo.length,
    );
  }

  Widget _buildTask(Task task) {
    return Card(
        child: ListTile(
          title: Text(task.title),
          subtitle: Text(task.subtitle),
          trailing: Icon(Icons.more_vert),
          onTap: () => _removeTodoItem(task),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TodoList Page"),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        /*ここが重要すぎる！！！*/
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TodoForm()),
            );
            if(result != null) {
              _todo.addAll(<Task>[]..length = 1);
              _todo[_todo.length - 1] = result;
            }
          },
          child: new Icon(Icons.add)
      ),
    );
  }
}

class Task{
  /*プロパティ*/
  int _id; //タスクを識別
  String _title; //タイトル
  String _subtitle; //サブタイトル

  /*コンストラクター*/
  Task(this._id,this._title,this._subtitle);

  /*ゲッター*/
  int get id => _id;
  String get title => _title;
  String get subtitle => _subtitle;

}

/*遷移先のフォーム*/
class TodoForm extends StatefulWidget {
  TodoForm({Key key, this.title}) : super(key: key);
  final String title;
  @override
  TodoFormState createState() => TodoFormState();
}

class TodoFormState extends State<TodoForm> {

  int _id;
  String _title;
  String _subtitle;
  Task task;
  final _formKey = GlobalKey<FormState>();

  void _buildTask() {
    task = Task(_id, _title, _subtitle);
    print(_id);
    print(_title);
    print(_subtitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task Page"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value.isEmpty) { //何も値を入力してない時
                  return 'タイトルを入力してください。';
                } else { //値を入力している時
                  return null;
                }
              },
              onSaved: (value) {
                setState(() {
                  _title = value; //タイトルを更新する
                });
              },
              decoration: InputDecoration(
                  hintText: "Input title",
                  contentPadding: const EdgeInsets.all(16.0)
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {  //何も値を入力してない時
                  return 'タイトルを入力してください。';
                } else {  //値を入力している時
                  return null;
                }
              },
              onSaved: (value) {
                setState(() {
                  _subtitle = value; //サブタイトルを更新
                });
              },
              decoration: InputDecoration(
                  hintText: "Input subtitle",
                  contentPadding: const EdgeInsets.all(16.0)
              ),
            ),
            RaisedButton(
              onPressed: () {
                if(_formKey.currentState.validate()){
                  _formKey.currentState.save();
                  _buildTask();
                  Navigator.of(context).pop(task);
                }
              },
              child: Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
