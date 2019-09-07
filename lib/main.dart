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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TodoList Page"),
      ),
      body: Text("aaa"),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TodoForm()),
            );
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
  final _formKey = GlobalKey<FormState>();

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
                Navigator.pop(context);
              },
              child: Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}