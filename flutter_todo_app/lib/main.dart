import 'package:flutter/material.dart';

final appTitle = "Simple To-Do list";

final kDefaultTheme = ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.blueAccent,
  scaffoldBackgroundColor: Colors.grey[100],
  primaryTextTheme: TextTheme(
      title: TextStyle(
        color: Colors.black,
        fontFamily: 'Gotham',
        fontSize: 26.0,
      ),
  ),
);

void main() {
  return runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: kDefaultTheme,
      home: ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {

  ToDoListScreen({Key key}) : super(key: key);

  @override
  State createState() => ToDoListScreenState();
}

List<Todo> todos = <Todo>[];

class ToDoListScreenState extends State<ToDoListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appTitle),
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) => todos[index],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FloatingActionButton(
          tooltip: 'Add',
          child: Icon(Icons.add, size: 35.0,),
          onPressed: () {
            setState(() {
              todos.add(Todo(title: "", isEditing: true,));
            });
          },
        ),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

const _rowHeight = 60.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

class Todo extends StatefulWidget {
  final String title;
  final bool isEditing;

  const Todo(
      {Key key, @required this.title, @required this.isEditing})
      :
        assert(title != null),
        assert(isEditing != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TodoState(todo: this);
  }
}

class TodoState extends State<Todo> {
  final Todo todo;
  bool isEditing = true;
  TextEditingController _textEditingController = TextEditingController();
  TodoState({this.todo});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(todo.title),
      onDismissed: (direction) {
          todos.remove(Todo(title: todo.title,isEditing: false,));
      },
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            color: Colors.white,
            elevation: 6.0,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              borderRadius: _borderRadius,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  enabled: isEditing ? true : false,
                  controller: _textEditingController,
                  onSubmitted: _handleSubmitted,
                  decoration: InputDecoration.collapsed(
                      hintText: "Write your task here..."
                  ),
                ),
                ),
              ),
            ),
          ),
        ),
      );
  }
  void _handleSubmitted(String text) {
    setState(() {
      isEditing = false;
    });
  }
}