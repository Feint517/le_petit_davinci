// import 'package:flutter/material.dart';
// import 'package:le_petit_davinci/core/constants/colors.dart';
// import 'package:le_petit_davinci/core/widgets/misc/animated_mascot.dart';

// /// A test page to demonstrate Rive mascot animations
// class RiveMascotTestPage extends StatefulWidget {
//   const RiveMascotTestPage({super.key});

//   @override
//   State<RiveMascotTestPage> createState() => _RiveMascotTestPageState();
// }

// class _RiveMascotTestPageState extends State<RiveMascotTestPage> {
//   MascotAnimationType _currentAnimationType = MascotAnimationType.talking;
//   final List<String> _messages = [
//     'Hello! I\'m your talking mascot!',
//     'I can show different animations!',
//     'Tap me to see me in action!',
//     'I\'m here to help you learn!',
//   ];
//   int _currentMessageIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundLight,
//       appBar: AppBar(
//         title: const Text('Rive Mascot Test'),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Animation type selector
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildAnimationButton(
//                     'Talking',
//                     MascotAnimationType.talking,
//                     AppColors.primary,
//                   ),
//                   _buildAnimationButton(
//                     'Happy',
//                     MascotAnimationType.happy,
//                     Colors.green,
//                   ),
//                   _buildAnimationButton(
//                     'Sad',
//                     MascotAnimationType.sad,
//                     AppColors.error,
//                   ),
//                 ],
//               ),
//             ),

//             // Mascot display
//             Expanded(
//               child: Center(
//                 child: AnimatedMascot(
//                   mascotSize: 250,
//                   bubbleText: _messages[_currentMessageIndex],
//                   bubbleWidth: 200,
//                   bubbleColor: _getBubbleColor(),
//                   animationType: _currentAnimationType,
//                   onTap: _nextMessage,
//                 ),
//               ),
//             ),

//             // Controls
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   Text(
//                     'Current Animation: ${_currentAnimationType.name.toUpperCase()}',
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Message ${_currentMessageIndex + 1} of ${_messages.length}',
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAnimationButton(
//     String label,
//     MascotAnimationType type,
//     Color color,
//   ) {
//     final isSelected = _currentAnimationType == type;
//     return ElevatedButton(
//       onPressed: () {
//         setState(() {
//           _currentAnimationType = type;
//           _currentMessageIndex = 0; // Reset message index
//         });
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: isSelected ? color : Colors.grey[300],
//         foregroundColor: isSelected ? Colors.white : Colors.black,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       ),
//       child: Text(label),
//     );
//   }

//   Color _getBubbleColor() {
//     switch (_currentAnimationType) {
//       case MascotAnimationType.talking:
//         return AppColors.primary;
//       case MascotAnimationType.happy:
//         return Colors.green;
//       case MascotAnimationType.sad:
//         return AppColors.error;
//     }
//   }

//   void _nextMessage() {
//     setState(() {
//       _currentMessageIndex = (_currentMessageIndex + 1) % _messages.length;
//     });
//   }
// }
