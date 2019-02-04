import 'package:flutter/material.dart';

final appTitle = "Simple To-do list";

final kDefaultTheme = ThemeData(
  primarySwatch: Colors.lightGreen,
  accentColor: Colors.lightGreenAccent,
);

void main() {
  return runApp( ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: kDefaultTheme,
      home: ToDoListScreen(
        todos: List.generate(
        1,
            (i) => Todo(
          'Example todo',
          'Hello world!',
        ),
      ),),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  final List<Todo> todos;

  ToDoListScreen({Key key, @required this.todos}) : super(key: key);

  @override
  State createState() => ToDoListScreenState(todos: todos);
}

class ToDoListScreenState extends State<ToDoListScreen> {
  final List<Todo> todos;

  ToDoListScreenState({this.todos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appTitle)),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(todos[index].title),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailToDoScreenRoute(todo: todos[index]),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateToDoScreenRoute())
          );
        },
      ),
    );
  }
}

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

class CreateToDoScreenRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create note'),
      ),
      body: Column(

      ),
    );
  }
}

class DetailToDoScreenRoute extends StatelessWidget {
  final Todo todo;

  DetailToDoScreenRoute({Key key, @required this.todo}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
    );
  }
}