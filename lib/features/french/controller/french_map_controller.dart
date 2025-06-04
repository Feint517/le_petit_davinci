import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // For RenderBox
import 'package:get/get.dart'; // Import GetX

class FrenchMapController extends GetxController {
  // GlobalKey must be initialized before use.
  // It's still managed here as it's part of the state required for measurement.
  final GlobalKey svgKey = GlobalKey();

  // Make these observable so the UI rebuilds when they change
  final RxDouble _svgRenderedWidth = RxDouble(0.0);
  final RxDouble _svgRenderedHeight = RxDouble(0.0);

  // Expose them as getters (optional, but good practice)
  double? get svgRenderedWidth => _svgRenderedWidth.value == 0.0 ? null : _svgRenderedWidth.value;
  double? get svgRenderedHeight => _svgRenderedHeight.value == 0.0 ? null : _svgRenderedHeight.value;

  @override
  void onInit() {
    super.onInit();
    // No direct measurement here, as it needs the UI to be built.
    // The view will call getSvgDimensions after the first frame.
  }

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