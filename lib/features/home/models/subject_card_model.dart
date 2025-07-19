import 'package:flutter/material.dart';

class SubjectCardModel {
  final String name;
  final String imagePath;
  final Color cardColor;
  final Widget? destination;

  const SubjectCardModel({
    required this.name,
    required this.imagePath,
    required this.cardColor,
    this.destination,
  });
}
