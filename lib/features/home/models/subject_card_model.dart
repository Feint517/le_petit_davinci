import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectCardModel {
  const SubjectCardModel({
    required this.name,
    required this.imagePath,
    required this.cardColor,
    this.destination,
    this.bindings,
  });

  final String name;
  final String imagePath;
  final Color cardColor;
  final Widget? destination;
  final Bindings? bindings;
}
