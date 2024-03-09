import 'package:flutter/material.dart';

class MyBoy extends StatelessWidget {
  MyBoy(
      {super.key,
      required this.boySpriteCount,
      required this.direction,
      required this.location});
  final int boySpriteCount; //0 - standing, 1-2 - walking
  String direction;
  final String location;
  double height = 22;

  @override
  Widget build(BuildContext context) {
    Matrix4 transform;

    if (location == 'littleroot') {
      height = 20;
    } else if (location == 'pokelab') {
      height = 30;
    } else if (location == 'battleground' ||
        location == 'attackoptions' ||
        location == 'battlefinishedscreen') {
      height = 0;
    }

    if (direction == 'Right') {
      direction = 'Left';
    }
    return Container(
        height: height,
        child: Image.asset(
          'lib/images/boy' + direction + boySpriteCount.toString() + '.png',
          fit: BoxFit.cover,
        ));
  }
}
