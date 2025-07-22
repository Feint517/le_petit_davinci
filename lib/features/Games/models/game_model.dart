import 'package:flutter/material.dart';

class GameModel {
  GameModel({
    required this.name,
    required this.numOfVictories,
    required this.color,
    required this.icon,
    required this.goToGameScreen,
  });

  final String name;
  final int numOfVictories;
  final Color color;
  final String icon;
  final VoidCallback goToGameScreen;
}
