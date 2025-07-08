// import 'package:flutter/material.dart';

// class StaggeredPage extends StatefulWidget {
//   const StaggeredPage({super.key});

//   @override
//   State<StaggeredPage> createState() => _StaggeredPageState();
// }

// class _StaggeredPageState extends State<StaggeredPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late List<Animation<double>> _fadeAnimations;

//   final int _numItems = 5; // total number of widgets
//   final Duration _totalDuration = Duration(milliseconds: 1500);

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(vsync: this, duration: _totalDuration);

//     _fadeAnimations = List.generate(_numItems, (index) {
//       final start = (index / _numItems);
//       final end = (index + 1) / _numItems;
//       return CurvedAnimation(
//         parent: _controller,
//         curve: Interval(start, end, curve: Curves.easeOut),
//       );
//     });

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Widget _buildItem(int index, String text) {
//     return FadeTransition(
//       opacity: _fadeAnimations[index],
//       child: SlideTransition(
//         position: _fadeAnimations[index].drive(
//           Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: Text(text, style: TextStyle(fontSize: 22)),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final items = [
//       "Welcome to the page",
//       "Here’s your profile",
//       "Check out the stats",
//       "Notifications go here",
//       "Let's get started!",
//     ];

//     return Scaffold(
//       appBar: AppBar(title: Text("Staggered Page")),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: List.generate(
//             _numItems,
//             (index) => _buildItem(index, items[index]),
//           ),
//         ),
//       ),
//     );
//   }
// }
