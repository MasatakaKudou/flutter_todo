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

  var yearList =[];
  var monthList = [];
  var dayList = [];
  List todoList = [];
  var num = 0;


  final formKey = GlobalKey<FormState>();
  final yearFocus = FocusNode();
  final monthFocus = FocusNode();
  final dayFocus = FocusNode();
  final todoFocus = FocusNode();

  void newYear(var _year){
    setState(() {
      yearList += _year;
    });
  }

  void newMonth(var _month){
    setState(() {
      monthList += _month;
    });
  }

  void newDay(var _day){
    setState(() {
      dayList += _day;
    });
  }

  void newTodo(var _todo){
    setState(() {
      todoList += _todo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  yearFormField(context),
                  monthFormField(context),
                  dayFormField(context),
                  todoFormField(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: RaisedButton(
                        onPressed: (){
                          if(formKey.currentState.validate()){
                            formKey.currentState.save();
                          }
                        },
                        child: Text('Add task'),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '<TodoList>'
            ),
          ],
        ),
      ),
    );
  }

  TextFormField yearFormField(BuildContext context){
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      autofocus: true,
      decoration: InputDecoration(labelText: "年を入力してください"),
      focusNode: yearFocus,
      onFieldSubmitted: (v) {
        yearFocus.unfocus();
      },
      onSaved: (value){
        newYear(int.parse(value));
      },
    );
  }

  TextFormField monthFormField(BuildContext context){
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      autofocus: true,
      decoration: InputDecoration(labelText: "月を入力してください"),
      focusNode: monthFocus,
      onFieldSubmitted: (v) {
        monthFocus.unfocus();
      },
      onSaved: (value){
        newMonth(int.parse(value));
      },
    );
  }

  TextFormField dayFormField(BuildContext context){
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      autofocus: true,
      decoration: InputDecoration(labelText: "日を入力してください"),
      focusNode: dayFocus,
      onFieldSubmitted: (v) {
        dayFocus.unfocus();
      },
      onSaved: (value){
        newDay(int.parse(value));
      },
    );
  }

  TextFormField todoFormField(BuildContext context){
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      autofocus: true,
      decoration: InputDecoration(labelText: "やることを入力してください"),
      focusNode: todoFocus,
      onFieldSubmitted: (v) {
        todoFocus.unfocus();
      },
      onSaved: (value){
        newDay(int.parse(value));
      },
    );
  }

}
