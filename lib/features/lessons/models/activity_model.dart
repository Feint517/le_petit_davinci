import 'package:flutter/material.dart';
import 'package:get/get.dart';

//* Base class for any lesson activity.
abstract class Activity {
  //? A reactive boolean to track if the activity has been completed.
  //? It starts as false.
  final RxBool isCompleted = false.obs;

  Widget build(BuildContext context);

  /// An optional method for activities to clean up their resources (e.g., controllers).
  /// It has a default empty implementation so not all activities need to define it.
  void dispose() {}
}

class Lesson {
  final String lessonId;
  final String title;
  final String introduction;
  final List<Activity> activities;

  Lesson({
    required this.lessonId,
    required this.title,
    required this.introduction,
    required this.activities,
  });
}
