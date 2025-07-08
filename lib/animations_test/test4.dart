// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:le_petit_davinci/features/rewards/views/rewards.dart';

// class SplashAnimation extends StatefulWidget {
//   const SplashAnimation({super.key});

//   @override
//   State<SplashAnimation> createState() => _SplashAnimationState();
// }

// class _SplashAnimationState extends State<SplashAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//   late Animation<double> scaleAnimation;

//   @override
//   void initState() {
//     controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 500),
//     );

//     controller.addListener(() {
//       if (controller.isCompleted) {
//         Navigator.of(
//           context,
//         ).push(MyCustomRouteTransition(route: const RewardsScreen()));
//         Timer(const Duration(milliseconds: 500), () => controller.reset());
//       }
//     });

//     scaleAnimation = Tween<double>(begin: 1, end: 11).animate(controller);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: GestureDetector(
//           onTap: () {
//             controller.forward();
//           },
//           child: ScaleTransition(
//             scale: scaleAnimation,
//             child: Container(
//               width: 100,
//               height: 100,
//               decoration: const BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//               ),
//               child: Container(
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Destination extends StatelessWidget {
//   const Destination({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       appBar: AppBar(title: const Text('Go Back')),
//     );
//   }
// }

// class MyCustomRouteTransition extends PageRouteBuilder {
//   MyCustomRouteTransition({required this.route})
//     : super(
//         pageBuilder: (context, animation, secondaryAnimation) => route,
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           //? what transition do you want to add while going to this page
//           final tween = Tween<double>(begin: 0, end: 1).animate(
//             CurvedAnimation(parent: animation, curve: Curves.easeInOut),
//           );
//           return FadeTransition(opacity: tween, child: child);
//         },
//       );

//   final Widget route;
// }
