import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/features/lessons2/models/draw_letter_activity_model.dart';
import 'package:le_petit_davinci/features/lessons2/models/lesson_model.dart';
import 'package:le_petit_davinci/features/lessons2/models/select_item_activity_model.dart';

final alphabetLesson = Lesson(
  id: 'alphabet_lesson_1',
  title: 'Learning Letters A-E',
  description:
      'Learn how to recognize and write the first five letters of the alphabet.',
  youtubeVideoId: 'ccEpTTZW34g',
  levelNumber: 1,
  thumbnailImagePath: TestAssets.videoThumbnail,
  activities: [
    LessonActivity.drawLetters(
      id: 'draw_letter_a',
      title: 'Draw Letter A',
      instruction: 'Trace the letter A with your finger',
      letters: [
        LetterModel(
          letter: 'A',
          templatePath: ImageAssets.drawableA,
          pronunciation: 'ay',
        ),
      ],
    ),
    // LessonActivity.selectItems(
    //   id: 'identify_letters',
    //   title: 'Identify Letters',
    //   instruction: 'Select all the letters that appear in the word "BEAR"',
    //   items: [
    //     SelectableItem(
    //       id: 'letter_a',
    //       label: 'A',
    //       imagePath: ImageAssets.drawableA,
    //     ),
    //     SelectableItem(
    //       id: 'letter_b',
    //       label: 'B',
    //       imagePath: ImageAssets.drawableB,
    //     ),
    //     SelectableItem(
    //       id: 'letter_e',
    //       label: 'E',
    //       imagePath: ImageAssets.drawableE,
    //     ),
    //     SelectableItem(
    //       id: 'letter_f',
    //       label: 'F',
    //       imagePath: ImageAssets.drawableF,
    //     ),
    //     SelectableItem(
    //       id: 'letter_c',
    //       label: 'C',
    //       imagePath: ImageAssets.drawableC,
    //     ),
    //     SelectableItem(
    //       id: 'letter_d',
    //       label: 'D',
    //       imagePath: ImageAssets.drawableD,
    //     ),
    //   ],
    //   correctAnswers: ['letter_b', 'letter_e', 'letter_a', 'letter_r'],
    // ),
  ],
);
