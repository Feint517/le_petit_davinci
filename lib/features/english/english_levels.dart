import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/features/Mathematic/models/level_model.dart';
import 'package:le_petit_davinci/features/Mathematic/models/section_data_model.dart';
import 'package:le_petit_davinci/features/exercises/data/fill_the_blank_data.dart';
import 'package:le_petit_davinci/features/exercises/data/listen_and_choose_data.dart';
import 'package:le_petit_davinci/features/exercises/data/reorder_words_data.dart';
import 'package:le_petit_davinci/features/exercises/views/fill_the_blank.dart';
import 'package:le_petit_davinci/features/exercises/views/listen_and_choose.dart';
import 'package:le_petit_davinci/features/exercises/views/reorder_words.dart';
import 'package:le_petit_davinci/features/french/view/video_lesson.dart';

final englishMapSections = [
  SectionData(
    color: AppColors.secondary,
    etapa: 1,
    seccion: 1,
    title: 'Alphabets',
    levels: [
      LevelModel(
        title: 'Level 1',
        levelType: LevelType.lesson,
        levelStatus: LevelStatus.inProgress,
        onTap:
            () => Get.to(() => const VideoLessonScreen(videoId: 'ccEpTTZW34g')),
      ),
      LevelModel(
        title: 'Level 2',
        levelType: LevelType.exercise,
        levelStatus: LevelStatus.inProgress,
        onTap:
            () => Get.to(
              () => FillTheBlankScreen(exercises: fillTheBlankLevels[2] ?? []),
            ),
      ),
      LevelModel(
        title: 'Level 3',
        levelType: LevelType.exercise,
        levelStatus: LevelStatus.inProgress,
        onTap:
            () => Get.to(
              () => ListenAndChooseScreen(
                exercises: listenAndChooseLevels[3] ?? [],
              ),
            ),
      ),
      LevelModel(
        title: 'Level 4',
        levelType: LevelType.exercise,
        levelStatus: LevelStatus.inProgress,
        onTap:
            () => Get.to(
              () => ReorderWordsScreen(exercises: reorderWordsLevels[4] ?? []),
            ),
      ),
      LevelModel(
        title: 'Level 5',
        levelType: LevelType.lesson,
        levelStatus: LevelStatus.inProgress,
        // onTap: () => Get.to(() => const VictoryScreen()),
      ),
      LevelModel(
        title: 'Level 6',
        levelType: LevelType.lesson,
        levelStatus: LevelStatus.inProgress,
        // onTap: () => Get.to(() => const VictoryScreen()),
      ),
      LevelModel(
        title: 'Level 7',
        levelType: LevelType.lesson,
        levelStatus: LevelStatus.locked,
      ),
      LevelModel(
        title: 'Level 8',
        levelType: LevelType.lesson,
        levelStatus: LevelStatus.locked,
      ),
      LevelModel(
        title: 'Level 9',
        levelType: LevelType.lesson,
        levelStatus: LevelStatus.locked,
      ),
    ],
  ),
];
