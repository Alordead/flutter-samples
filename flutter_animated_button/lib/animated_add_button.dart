import 'package:flutter/material.dart';

class AnimatedAddButton extends StatefulWidget {

  final Color buttonColor = Colors.lightBlue;

  @override
  AnimatedAddButtonState createState() {
    return AnimatedAddButtonState();
  }
}

class AnimatedAddButtonState extends State<AnimatedAddButton> {

  var _isTapped = false;
  var _opacity = 0.0;
  var _width = 50.0;

  final _opacityMilliseconds = 200;
  final IconData _buttonIcon = Icons.group_add;
  final String _buttonTitle = "Added";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isTapped = !_isTapped;
          _opacity = _isTapped ? 1.0 : 0.0;
          _width = _isTapped ? 100.0 : 50.0;
        });
      },
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: AnimatedContainer(
          duration: Duration(milliseconds: _opacityMilliseconds),
          alignment: Alignment.center,
          curve: Curves.linear,
          height: 50.0,
          width: _width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(color: (_isTapped ? widget.buttonColor : Colors.transparent), width: 3.0),
            color: _isTapped ? Colors.transparent : Colors.lightBlue ,
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: _opacityMilliseconds),
                  opacity: _opacity == 0.0 ? 1.0 : 0.0,
                  child: Icon(
                    _buttonIcon,
                    color: Colors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: _opacityMilliseconds),
                  opacity: _opacity,
                  child: Text(
                    _buttonTitle,
                    style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}