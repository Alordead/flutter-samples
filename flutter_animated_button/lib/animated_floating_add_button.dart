import 'package:flutter/material.dart';

class AnimatedFloatingActionButton extends StatefulWidget {
  @override
  _AnimatedFloatingActionButtonState createState() => _AnimatedFloatingActionButtonState();
}

class _AnimatedFloatingActionButtonState extends State<AnimatedFloatingActionButton>
    with SingleTickerProviderStateMixin {

  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _animateColor;
  Animation<double> _animateIcon;
  Curve _curve = Curves.easeOut;

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
    ).animate(CurvedAnimation(parent: _animationController, curve: Interval(0.00, 1.00, curve: _curve),
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
    return toggle();
  }
}