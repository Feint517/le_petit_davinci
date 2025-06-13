import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MathLessonsController extends GetxController {
  // GlobalKey must be initialized before use.
  // It's still managed here as it's part of the state required for measurement.
  final GlobalKey svgKey = GlobalKey();

  // Make these observable so the UI rebuilds when they change
  final RxDouble _svgRenderedWidth = RxDouble(0.0);
  final RxDouble _svgRenderedHeight = RxDouble(0.0);

  // Expose them as getters (optional, but good practice)
  double? get svgRenderedWidth => _svgRenderedWidth.value == 0.0 ? null : _svgRenderedWidth.value;
  double? get svgRenderedHeight => _svgRenderedHeight.value == 0.0 ? null : _svgRenderedHeight.value;

  /// Call this method from the View's initState after the first frame is built.
  void getSvgDimensions() {
    // Ensure the key's current context is mounted and has a RenderBox
    if (svgKey.currentContext != null) {
      final RenderBox renderBox = svgKey.currentContext!.findRenderObject() as RenderBox;
      // No need for 'mounted' check here as this method is called from the view
      // which already ensures it's mounted.
      _svgRenderedWidth.value = renderBox.size.width;
      _svgRenderedHeight.value = renderBox.size.height;
 
    } else {
      print('Controller: Warning: svgKey.currentContext is null. Could not get dimensions.');
    }
  }
}