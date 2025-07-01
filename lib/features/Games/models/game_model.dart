import 'package:flutter/material.dart';

class GameModel {
  GameModel({
    required this.name,
    required this.numOfVictories,
    required this.color,
    required this.icon,
    required this.gameScreen,
  });

  String name;
  int numOfVictories;
  Color color;
  String icon;
  Widget gameScreen;
}
