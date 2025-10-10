import 'package:get/get.dart';
import 'package:le_petit_davinci/features/leaderboard/models/player_model.dart';
import 'package:le_petit_davinci/services/progress_service.dart';

class LeaderboardController extends GetxController {
  List<PlayerModel> leaderboardData = [];

  @override
  void onInit() {
    super.onInit();
    _loadLeaderboardData();
  }

  void _loadLeaderboardData() {
    // Mock data for now - in a real app, this would come from an API
    leaderboardData = [
      PlayerModel(
        id: '1',
        name: 'Alex Johnson',
        avatar: '👦',
        totalStars: 156,
        level: 12,
        isCurrentUser: false,
      ),
      PlayerModel(
        id: '2',
        name: 'Emma Wilson',
        avatar: '👧',
        totalStars: 142,
        level: 11,
        isCurrentUser: false,
      ),
      PlayerModel(
        id: '3',
        name: 'Lucas Brown',
        avatar: '👦',
        totalStars: 138,
        level: 10,
        isCurrentUser: false,
      ),
      PlayerModel(
        id: '4',
        name: 'Sophia Davis',
        avatar: '👧',
        totalStars: 125,
        level: 9,
        isCurrentUser: false,
      ),
      PlayerModel(
        id: '5',
        name: 'You',
        avatar: '🌟',
        totalStars: _getCurrentUserStars(),
        level: _getCurrentUserLevel(),
        isCurrentUser: true,
      ),
      PlayerModel(
        id: '6',
        name: 'Mia Garcia',
        avatar: '👧',
        totalStars: 98,
        level: 8,
        isCurrentUser: false,
      ),
      PlayerModel(
        id: '7',
        name: 'Noah Martinez',
        avatar: '👦',
        totalStars: 87,
        level: 7,
        isCurrentUser: false,
      ),
      PlayerModel(
        id: '8',
        name: 'Isabella Rodriguez',
        avatar: '👧',
        totalStars: 76,
        level: 6,
        isCurrentUser: false,
      ),
    ];

    // Sort by total stars (descending)
    leaderboardData.sort((a, b) => b.totalStars.compareTo(a.totalStars));
    
    update();
  }

  int _getCurrentUserStars() {
    try {
      final progressService = ProgressService.instance;
      final englishStars = progressService.totalStars('en');
      final frenchStars = progressService.totalStars('fr');
      return englishStars + frenchStars;
    } catch (e) {
      return 0;
    }
  }

  int _getCurrentUserLevel() {
    try {
      final progressService = ProgressService.instance;
      final englishLevels = progressService.getUnlockedLevels('en');
      final frenchLevels = progressService.getUnlockedLevels('fr');
      return (englishLevels.length + frenchLevels.length) ~/ 2;
    } catch (e) {
      return 1;
    }
  }

  void refreshLeaderboard() {
    _loadLeaderboardData();
  }
}


