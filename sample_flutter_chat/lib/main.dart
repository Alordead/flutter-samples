import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.red,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.red,
  accentColor: Colors.redAccent,
);

void main() => runApp(SimpleChat());

class SimpleChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Chat!',
      theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme,
      home: LoginScreen(),
    );
  }
}

class Person {
  Person({this.name});
  String name;

  String getName() {
    return name;
  }
  void setName(String text) {
    name = text;
  }
}

Person person = Person(name: "Anonimous");

class LoginScreen extends StatefulWidget {
  @override
  State createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _textController = TextEditingController();
  bool _isComposing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Let me know your name: "),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: _textController,
                        onSubmitted: _handleSubmitted,
                        decoration: InputDecoration.collapsed(
                            hintText: "Ivan Ivanov"),
                      ),
                    ),
                    RaisedButton(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      colorBrightness: Theme
                          .of(context)
                          .primaryColorBrightness,
                      onPressed: () {
                        _handleSubmitted(_textController.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatScreen()),
                        );
                      },
                      child: Text("Send"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
  void _handleSubmitted(String text) {
    person.setName(text);
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
}

final List<ChatMessage> messages = <ChatMessage>[];

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Simple Chat'),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 5.0,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => messages[index],
              itemCount: messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Theme.of(context).platform == TargetPlatform.iOS ?
              CupertinoButton(
                child: Text("Send"),
                onPressed: _isComposing ? () => _handleSubmitted(_textController.text) : null) :
              IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _isComposing ? () => _handleSubmitted(_textController.text) : null),
            )
          ],
        ),
      )
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    if (text.length > 0) {
      ChatMessage message = ChatMessage(
        text: text,
        animationController: AnimationController(
          duration: Duration(milliseconds: 500),
          vsync: this,
        ),
      );
      setState(() {
        messages.insert(0, message);
      });
      message.animationController.forward();
    }
  }

  @override
  void dispose() {
    for (ChatMessage message in messages)
      message.animationController.dispose();
    super.dispose();
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(text),
      background: Container(
        color: Theme.of(context).primaryColorDark,
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: <Widget>[Text(
              "Delete",
              style: TextStyle(color: Colors.white),
              textScaleFactor: 1.5
          )
          ],
        ),
      ),
      onDismissed: (direction) {
        messages.remove(this);
      },
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeIn),
        axisAlignment: 0.0,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 12.0),
                child: CircleAvatar(child: Text(person.getName()[0])),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(person.getName(), style: Theme.of(context).textTheme.subhead),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: Text(text),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}