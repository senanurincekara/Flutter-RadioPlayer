import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Duration _duration = const Duration(milliseconds: 200);
  final Widget child;
  final Color color;

  const CustomButton({
    super.key,
    required this.child,
    required this.color,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  double _size = 60.0;
  double _size2 = 60.0;
  final Curve _curve = Curves.easeInCirc;

  void _pressed(_) {
    setState(() {
      _size = 62.0; // basınca
    });
  }

  void _unPressedOnTapUp(_) => _unPressed();

  void _unPressed() {
    setState(() {
      _size = 60.0; //kendi boyutu
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: GestureDetector(
        onTapDown: _pressed,
        onTapUp: _unPressedOnTapUp,
        onTapCancel: _unPressed,
        child: Stack(children: [
          Positioned(
            top: 2,
            left: 3,
            child: Container(
              width: _size2 - 1,
              height: _size2 - 1,
              decoration:
                  BoxDecoration(color: Colors.black, shape: BoxShape.circle),
            ),
          ),
          Container(
            width: _size, // Animating the width
            height: _size,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            alignment: Alignment.center,
            child: widget.child,
          ),
        ]),
      ),
    );
  }
}
