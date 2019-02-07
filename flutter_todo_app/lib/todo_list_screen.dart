import 'package:flutter/material.dart';
import 'main.dart';
import 'todo.dart';

class ToDoListScreen extends StatefulWidget {

  ToDoListScreen({Key key}) : super(key: key);

  @override
  State createState() => ToDoListScreenState();
}

List<Todo> todos = List<Todo>();
int count = 0;

class ToDoListScreenState extends State<ToDoListScreen> {

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
              itemBuilder: (context, index) {
                final todo = todos[index];
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  key: ObjectKey(todo),
                  onDismissed: (direction) {
                    setState(() {
                      todos.removeAt(index);
                      count -= 1;
                    });
                  },
                  child: Todo(todo: todo),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: todoFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  double floatingButtonNeedsBottomInsets() {
    return MediaQuery.of(context).viewInsets.bottom == 0 ? 70.0 : 0.0;
  }

  Widget todoFloatingActionButton() {
    return Container(
      height: floatingButtonNeedsBottomInsets(),
      width: floatingButtonNeedsBottomInsets(),
      child: FloatingActionButton(
        tooltip: 'Add',
        child: Icon(Icons.add, size: 35.0,),
        onPressed: () {
          setState(() {
            Todo todo = Todo.create(index: count);
            todos.add(todo);
            count += 1;
          });
        },
      ),
    );
  }
}