import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mmo/button.dart';
import 'package:mmo/characters/boy.dart';
import 'package:mmo/maps/littleroot.dart';

void main() {
  runApp(const Game());
}

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //variables

  //littleroot
  double mapX = 0;
  double mapY = 0;

  //game stuff
  String currentLocation = 'littleroot';
  double step = 0.25;

  //boy
  // double boyX = 0;
  // double boyY = 0;

  int boySpriteCount = 0; //0 - standing, 1-2 - walk
  String boyDirection = 'Down';

  //no mans land fot littleroot

  List<List<double>> noMansLandLittleRoot = [
    [1.0, 0.5],
    [0.75, 0.5],
    [1.25, 0.5],
    [1.5, 0.5],
    [2.0, 0.25],
    [0.5, 0.5]
  ];

  bool canMoveTo(String direction, var noMansLand, double x, double y) {
    double stepX = 0;
    double stepY = 0;

    if (direction == 'Up') {
      stepY = stepY + 0.2;
    } else if (direction == 'Down') {
      stepY = stepY - 0.25;
    } else if (direction == 'Left') {
      stepX = stepX + 0.2;
    }

    for (int i = 0; i < noMansLand.length; i++) {
      if (((noMansLand[i][0]).toStringAsFixed(1) ==
              (x + stepX).toStringAsFixed(1)) &&
          ((noMansLand[i][1]).toStringAsFixed(1) ==
              (y + stepY).toStringAsFixed(1))) {
        return false;
      }
    }

    print('передаваемый  массив');
    print(noMansLand[0][0]);
    print(noMansLand[0][1]);
    print('координаты в функции');
    print((x + stepX).toStringAsFixed(1));
    print((y + stepY).toStringAsFixed(1));

    return true;
  }

  void moveUp() {
    boyDirection = 'Up';
    if (canMoveTo(boyDirection, noMansLandLittleRoot, mapX, mapY)) {
      setState(() {
        mapY += step;
      });
    }
    animateWalk();
  }

  void moveDown() {
    boyDirection = 'Down';
    if (canMoveTo(boyDirection, noMansLandLittleRoot, mapX, mapY)) {
      setState(() {
        mapY -= step;
      });
    }
    animateWalk();
  }

  void moveRight() {
    boyDirection = 'Right';

    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleRoot, mapX, mapY)) {
        setState(() {
          mapX -= step;
        });
      }
    }

    animateWalk();
  }

  void moveLeft() {
    boyDirection = 'Left';
    if (canMoveTo(boyDirection, noMansLandLittleRoot, mapX, mapY)) {
      setState(() {
        mapX += step;
      });
    }

    animateWalk();
  }

  void pressA() {
    print('pressed a');
  }

  void pressB() {
    print('pressed b');
  }

  void animateWalk() {
    print('координаты карты');
    print('x :' + mapX.toString());
    print('y :' + mapY.toString());

    Timer.periodic(Duration(milliseconds: 60), (timer) {
      setState(() {
        boySpriteCount++;
      });
      if (boySpriteCount == 3) {
        boySpriteCount = 0;
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AspectRatio(
            aspectRatio: 1,
            child: Container(
                color: Colors.black,
                child: Stack(children: [
                  //little root
                  LittleRoot(x: mapX, y: mapY, currentMap: currentLocation),
                  //boy
                  Container(
                    alignment: Alignment(0, 0),
                    child: MyBoy(
                      location: currentLocation,
                      boySpriteCount: boySpriteCount,
                      direction: boyDirection,
                    ),
                  ),
                ]))),
        Expanded(
            child: Container(
                color: Colors.grey[900],
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Game',
                        style: TextStyle(color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                  ),
                                  MyButton(text: '<', function: moveLeft),
                                  Container(
                                    height: 50,
                                    width: 50,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  MyButton(text: '^', function: moveUp),
                                  Container(
                                    height: 50,
                                    width: 50,
                                  ),
                                  MyButton(text: 'D', function: moveDown),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                  ),
                                  MyButton(text: '>', function: moveRight),
                                  Container(
                                    height: 50,
                                    width: 50,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          MyButton(text: 'a', function: pressA),
                          MyButton(text: 'b', function: pressB),
                        ],
                      ),
                      Text(
                        'Author',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )))
      ],
    ));
  }
}
