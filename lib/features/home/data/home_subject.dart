import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/Games/view/games_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/math_map.dart';
import 'package:le_petit_davinci/features/english/view/english_map.dart';
import 'package:le_petit_davinci/features/french/view/french_map.dart';
import 'package:le_petit_davinci/features/home/models/subject_card_model.dart';
import 'package:le_petit_davinci/features/math/views/math_map.dart';
import 'package:le_petit_davinci/features/studio/views/studio_main_screen.dart';
import 'package:le_petit_davinci/features/vieQuotidienne/view/vie_quotidienne.dart';

final List<SubjectCardModel> subjects = [
  SubjectCardModel(
    name: 'Français',
    imagePath: SvgAssets.frenchCard,
    cardColor: AppColors.primary,
    destination: const FrenchMapScreen(),
  ),
  SubjectCardModel(
    name: 'Mathématiques',
    imagePath: SvgAssets.mathCard,
    cardColor: AppColors.orangeAccent,
    destination: const MathMapScreen(),
  ),
  SubjectCardModel(
    name: 'English',
    imagePath: SvgAssets.englishCard,
    cardColor: AppColors.accent,
    destination: const EnglishMapScreen(),
  ),
  // SubjectCardModel(
  //   name: 'Vie quotidienne ',
  //   imagePath: SvgAssets.lifeCard,
  //   cardColor: AppColors.pinkAccent,
  //   destination: const VieQuotidienneScreen(),
  // ),
  SubjectCardModel(
    name: 'Jeux',
    imagePath: SvgAssets.gameCard,
    cardColor: AppColors.greenPrimary,
    destination: const GamesScreen(),
  ),
  SubjectCardModel(
    name: 'Studio',
    imagePath: SvgAssets.studioCard,
    cardColor: AppColors.primary,
    destination: const StudioMainScreen(),
  ),
];
