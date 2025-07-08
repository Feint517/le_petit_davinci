// import 'package:flutter/material.dart';
// import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';

// class AnimatedTransitionScreen extends StatefulWidget {
//   @override
//   _AnimatedTransitionScreenState createState() =>
//       _AnimatedTransitionScreenState();
// }

// class _AnimatedTransitionScreenState extends State<AnimatedTransitionScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;

//   bool _showOverlay = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 500),
//     );

//     _scaleAnimation = Tween<double>(
//       begin: 1.0,
//       end: 30.0,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

//     _controller.addStatusListener((status) async {
//       if (status == AnimationStatus.completed) {
//         // Navigate after the scale-up animation finishes
//         Navigator.of(context).push(
//           PageRouteBuilder(
//             pageBuilder: (_, __, ___) => TargetScreen(),
//             transitionDuration: Duration(
//               milliseconds: 0,
//             ), // No default transition
//           ),
//         );
//         _controller.reset();
//         setState(() {
//           _showOverlay = false;
//         });
//       }
//     });
//   }

//   void _onTap() {
//     setState(() {
//       _showOverlay = true;
//     });
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Main UI
//           Center(
//             child: GestureDetector(
//               onTap: _onTap,
//               child: Container(
//                 width: 100,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Center(child: Text('Tap Me')),
//               ),
//             ),
//           ),

//           // Scaling overlay
//           if (_showOverlay)
//             AnimatedBuilder(
//               animation: _controller,
//               builder: (context, child) {
//                 final scale = _scaleAnimation.value;
//                 return Center(
//                   child: Transform.scale(
//                     scale: scale,
//                     child: Container(
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         color: Colors.blue,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }

// class TargetScreen extends StatefulWidget {
//   @override
//   _TargetScreenState createState() => _TargetScreenState();
// }

// class _TargetScreenState extends State<TargetScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   bool _animationDone = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 500),
//     );

//     _scaleAnimation = Tween<double>(begin: 30.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     )..addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         setState(() {
//           _animationDone = true;
//         });
//       }
//     });

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomNavBar(),
//       body: Stack(
//         children: [
//           // Real content (revealed after animation)
//           if (_animationDone)
//             Center(
//               child: Text(
//                 'Welcome to the next screen!',
//                 style: TextStyle(fontSize: 24),
//               ),
//             ),

//           // Reverse scale effect
//           if (!_animationDone)
//             AnimatedBuilder(
//               animation: _controller,
//               builder: (_, __) {
//                 return Center(
//                   child: Transform.scale(
//                     scale: _scaleAnimation.value,
//                     child: Container(
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         color: Colors.blue,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }
