import 'package:flutter/material.dart';

class MyNumberBox extends StatelessWidget {
  MyNumberBox(
      {Key? key,
      required this.child,
      required this.revealed,
      required this.function})
      : super(key: key);
  final child;
  bool revealed;
  final function;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          color: revealed ? Colors.grey.shade300 : Colors.purple.shade400,
          child: Center(
            child: Text(
              revealed
                  ? child != 0
                      ? child.toString()
                      : ''
                  : '',
              style: TextStyle(
                color: child == 1
                    ? Colors.red
                    : child == 2
                        ? Colors.blue
                        : child == 3
                            ? Colors.green
                            : Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
