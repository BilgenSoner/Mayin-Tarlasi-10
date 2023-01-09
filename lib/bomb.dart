import 'package:flutter/material.dart';

class MyBomb extends StatelessWidget {
  MyBomb(
      {Key? key,
      required this.child,
      required this.revealed,
      required this.function})
      : super(key: key);
  final child;
  final function;
  bool revealed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          color: !revealed ? Colors.purple.shade400 : Colors.grey.shade800,
          child: Center(
            child: Text(
              revealed ? 'X' : '',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
