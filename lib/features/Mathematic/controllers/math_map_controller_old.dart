// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class MathMapController extends GetxController {
//   // final GlobalKey svgKey = GlobalKey();

//   // final RxDouble _svgRenderedWidth = RxDouble(0.0);
//   // final RxDouble _svgRenderedHeight = RxDouble(0.0);

//   // double? get svgRenderedWidth =>
//   //     _svgRenderedWidth.value == 0.0 ? null : _svgRenderedWidth.value;
//   // double? get svgRenderedHeight =>
//   //     _svgRenderedHeight.value == 0.0 ? null : _svgRenderedHeight.value;

//   // void getSvgDimensions() {
//   //   if (svgKey.currentContext != null) {
//   //     final RenderBox renderBox =
//   //         svgKey.currentContext!.findRenderObject() as RenderBox;
//   //     _svgRenderedWidth.value = renderBox.size.width;
//   //     _svgRenderedHeight.value = renderBox.size.height;
//   //     if (kDebugMode) {
//   //       print('SVG dimensions: ${renderBox.size}');
//   //     }
//   //   } else {
//   //     if (kDebugMode) {
//   //       print(
//   //         'Controller: Warning: svgKey.currentContext is null. Could not get dimensions.',
//   //       );
//   //     }
//   //   }
//   // }

//   List<String> levels = [];
//   ScrollController scrollController = ScrollController();

//   @override
//   void onInit() async {
//     super.onInit();
//     loadMoreLevels();

//     scrollController.addListener(() {
//       if (scrollController.position.pixels ==
//           scrollController.position.maxScrollExtent) {
//         loadMoreLevels();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }

//   void loadMoreLevels() {
//     // Simulate a network request
//     Future.delayed(Duration(seconds: 2), () {
//       //? Add new levels to the list
//       // levels.addAll(['Level 1', 'Level 2', 'Level 3']);
//       levels.addAll(
//         List.generate(10, (index) => 'Level ${levels.length + index + 1}'),
//       );
//     });
//   }
// }
