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

class ToDoListScreenState extends State<ToDoListScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appTitle),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(bottom: 75.0),
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
        height: MediaQuery.of(context).viewInsets.bottom == 0 ? 70.0 : 0.0,
        width: MediaQuery.of(context).viewInsets.bottom == 0 ? 70.0 : 0.0,
        child: FloatingActionButton(
          tooltip: 'Add',
          child: Icon(Icons.add, size: 35.0,),
          onPressed: () {
            setState(() {
              Todo todo = Todo();
              todos.add(todo);
            });
          },
        ),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

final _rowHeight = 60.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

class Todo extends StatefulWidget {
  String title;
  bool editing;

  Todo({this.title, this.editing});

  @override
  State<StatefulWidget> createState() {
    return TodoState(todo: this);
  }
}

class TodoState extends State<Todo> with TickerProviderStateMixin {
  Todo todo;

  AnimationController controller;
  Animation<double> animation;

  bool editing = true;
  bool readyButtonPressed = false;
  
  TextEditingController _textEditingController = TextEditingController();

  TodoState({this.todo});

  initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(todo.title),
      onDismissed: (direction) {
          todos.remove(Todo(title: todo.title, editing: this.editing,));
      },
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          child: FadeTransition(
            opacity: animation,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0),
              ),
              color: Colors.white,
              elevation: 6.0,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                borderRadius: _borderRadius,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            style: TextStyle(
                              color: readyButtonPressed ? Colors.grey[500] : Colors.black,
                              decoration: readyButtonPressed ? TextDecoration.lineThrough : null,
                              fontSize: 20.0,
                            ),
                            enabled: editing ? true : false,
                            controller: _textEditingController,
                            maxLengthEnforced: false,
                            onSubmitted: _handleSubmitted,
                            decoration: InputDecoration.collapsed(
                                hintText: "Write your task here..."
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: readyButtonPressed ? Colors.green[400] : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: IconButton(
                          iconSize: 25.0,
                          icon: Icon(Icons.done, color: Colors.white),
                          onPressed: this.editing == true ? null : _readyButtonPressed,
                        ),
                      )
                    ],
                  ),
                  ),
                ),
              ),
          ),
          ),
        ),
      );
  }

  void _readyButtonPressed() {
    setState(() {
      print(todos);
      this.readyButtonPressed = true;
    });
  }

  void _handleSubmitted(String text) {
    setState(() {
      this.editing = text.length == 0 ? true : false;
      todo.title = text;
      todo.editing = this.editing;
    });
  }
}