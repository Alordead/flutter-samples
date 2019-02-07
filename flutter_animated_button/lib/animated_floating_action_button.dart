import 'package:flutter/material.dart';

class AnimatedFloatingActionButton extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  AnimatedFloatingActionButton({this.onPressed, this.tooltip, this.icon});

  @override
  _AnimatedFloatingActionButtonState createState() => _AnimatedFloatingActionButtonState();
}

class _AnimatedFloatingActionButtonState extends State<AnimatedFloatingActionButton>
    with SingleTickerProviderStateMixin {

  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _animateColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300))
    ..addListener(() {
      setState(() {});
    });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(
      begin: Colors.lightBlue,
      end: Colors.redAccent,
    ).animate(CurvedAnimation(parent: _animationController, curve: Interval(0.00, 1.00, curve: Curves.linear),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Interval(
        0.0,
        0.75,
        curve: _curve
      ),
    ));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget add() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget image() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        tooltip: 'Image',
        child: Icon(Icons.image),
      ),
    );
  }

  Widget inbox() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        tooltip: 'Inbox',
        child: Icon(Icons.inbox),
      ),
    );
  }

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: _animateColor.value,
      onPressed: animate,
      tooltip: 'Toggle',
      child: AnimatedIcon(icon: AnimatedIcons.menu_close, progress: _animateIcon
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(0.0, _translateButton.value * 3.0, 0.0),
          child: add(),
        ),
        Transform(
          transform: Matrix4.translationValues(0.0, _translateButton.value * 2.0, 0.0),
          child: image(),
        ),
        Transform(
          transform: Matrix4.translationValues(0.0, _translateButton.value, 0.0),
          child: inbox(),
        ),
        toggle(),
      ],
    );
  }
}