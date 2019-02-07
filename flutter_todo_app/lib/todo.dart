import 'package:flutter/material.dart';
import 'todo_list_screen.dart';

final _rowHeight = 60.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

class Todo extends StatefulWidget {
  String title;
  bool editing;
  int index;

  Todo({Todo todo}) : this.title = todo.title, this.editing = todo.editing, this.index = todo.index;
  Todo.create({this.title, this.editing, @required this.index});

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
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
        child: FadeTransition(
          opacity: animation,
          child: todoCard(),
        ),
      ),
    );
  }

  Widget todoCard() {
    return Card(
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
              todoCardTextField(),
              todoCardReadyButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget todoCardTextField() {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          style: TextStyle(
            color:
            readyButtonPressed ? Colors.grey[500] : Colors.black,
            decoration: readyButtonPressed
                ? TextDecoration.lineThrough
                : null,
            fontSize: 20.0,
          ),
          enabled: editing ? true : false,
          controller: _textEditingController,
          maxLengthEnforced: false,
          onSubmitted: _handleSubmitted,
          decoration: InputDecoration.collapsed(
              hintText: "Write your task here..."),
        ),
      ),
    );
  }

  Widget todoCardReadyButton() {
    return Card(
      color: readyButtonPressed ? Colors.green[400] : Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: IconButton(
        iconSize: 25.0,
        icon: Icon(Icons.done, color: Colors.white),
        onPressed: this.editing == true ? null : _readyButtonPressed,
      ),
    );
  }

  void _readyButtonPressed() {
    setState(() {
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
