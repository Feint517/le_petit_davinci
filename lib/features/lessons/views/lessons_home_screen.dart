// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:le_petit_davinci/features/lessons/models/lesson_model.dart';
// import 'package:le_petit_davinci/features/lessons/data/lessons_data.dart';
// import 'package:le_petit_davinci/features/lessons/views/lesson_screen.dart';
// import 'package:le_petit_davinci/core/constants/colors.dart';
// import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
// import 'package:le_petit_davinci/features/lessons/controllers/lesson_controller.dart';

// class LessonsHomeScreen extends GetView<LessonController> {
//   const LessonsHomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         title: const Text(
//           'Lessons',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: AppColors.textPrimary,
//           ),
//         ),
//         backgroundColor: AppColors.primary,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Choose Your Learning Language',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//             const SizedBox(height: 20),

//             // English Lessons
//             _buildLanguageSection(
//               context: context,
//               title: 'English Lessons',
//               description:
//                   'Learn the English alphabet with fun videos and activities!',
//               lessons: getLessonsByLanguage(LessonLanguage.english),
//               color: AppColors.primary,
//             ),

//             const SizedBox(height: 20),

//             // French Lessons
//             _buildLanguageSection(
//               context: context,
//               title: 'French Lessons',
//               description:
//                   'Apprenez l\'alphabet français avec des vidéos et activités amusantes!',
//               lessons: getLessonsByLanguage(LessonLanguage.french),
//               color: AppColors.secondary,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLanguageSection({
//     required BuildContext context,
//     required String title,
//     required String description,
//     required List<LessonModel> lessons,
//     required Color color,
//   }) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: 4,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: color,
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.textPrimary,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         description,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: AppColors.textSecondary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),

//             // Lessons List
//             if (lessons.isEmpty)
//               const Text(
//                 'No lessons available yet.',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: AppColors.textSecondary,
//                   fontStyle: FontStyle.italic,
//                 ),
//               )
//             else
//               ...lessons.map((lesson) => _buildLessonCard(lesson, color)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLessonCard(LessonModel lesson, Color accentColor) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: accentColor.withValues(alpha: 0.2), width: 1),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 8,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: accentColor.withValues(alpha: 0.1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     'Level ${lesson.levelNumber}',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: accentColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const Spacer(),
//                 Icon(
//                   _getStatusIcon(lesson.status),
//                   color: _getStatusColor(lesson.status),
//                   size: 20,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(
//               lesson.title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               lesson.description,
//               style: const TextStyle(
//                 fontSize: 12,
//                 color: AppColors.textSecondary,
//               ),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 const Icon(
//                   Icons.schedule,
//                   size: 16,
//                   color: AppColors.textSecondary,
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   '${lesson.estimatedTotalMinutes} min',
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: AppColors.textSecondary,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 const Icon(
//                   Icons.assignment,
//                   size: 16,
//                   color: AppColors.textSecondary,
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   '${lesson.activities.length} activities',
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: AppColors.textSecondary,
//                   ),
//                 ),
//                 const Spacer(),
//                 CustomButton(
//                   label: _getButtonText(lesson.status),
//                   onPressed:
//                       lesson.status == LessonStatus.available
//                           ? () => _startLesson(lesson)
//                           : null,
//                   variant: ButtonVariant.primary,
//                   size: ButtonSize.sm,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   IconData _getStatusIcon(LessonStatus status) {
//     switch (status) {
//       case LessonStatus.available:
//         return Icons.play_circle_outline;
//       case LessonStatus.inProgress:
//         return Icons.refresh;
//       case LessonStatus.completed:
//         return Icons.check_circle;
//       case LessonStatus.locked:
//         return Icons.lock;
//     }
//   }

//   Color _getStatusColor(LessonStatus status) {
//     switch (status) {
//       case LessonStatus.available:
//         return AppColors.primary;
//       case LessonStatus.inProgress:
//         return AppColors.warning;
//       case LessonStatus.completed:
//         return AppColors
//             .succuss; // Note: keeping original typo from colors.dart
//       case LessonStatus.locked:
//         return AppColors.textSecondary;
//     }
//   }

//   String _getButtonText(LessonStatus status) {
//     switch (status) {
//       case LessonStatus.available:
//         return 'Start';
//       case LessonStatus.inProgress:
//         return 'Continue';
//       case LessonStatus.completed:
//         return 'Review';
//       case LessonStatus.locked:
//         return 'Locked';
//     }
//   }

//   void _startLesson(LessonModel lesson) {
//     Get.to(() => LessonScreen(lesson: lesson));
//   }
// }
