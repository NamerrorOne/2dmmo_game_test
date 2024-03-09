import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final text;
  final function;

  MyButton({required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: function,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: Colors.white)),
            child: Center(
                child: Text(text,
                    style: TextStyle(color: Colors.white, fontSize: 20))),
          ),
        ));
  }
}
