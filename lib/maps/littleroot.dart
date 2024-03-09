import 'package:flutter/material.dart';

class LittleRoot extends StatelessWidget {
  LittleRoot(
      {super.key, required this.x, required this.y, required this.currentMap});

  double x;
  double y;
  String currentMap;

  @override
  Widget build(BuildContext context) {
    if (currentMap == 'littleroot') {
      return Container(
          alignment: Alignment(x, y),
          child: Image.asset(
            'lib/images/littleroot.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.75,
          ));
    } else {
      return Container();
    }
  }
}
