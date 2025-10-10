// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:le_petit_davinci/services/storage_service.dart';

class ProgressService extends GetxService {
  static ProgressService get instance => Get.find<ProgressService>();

  GetStorage get _box {
    return StorageService.instance.localStorage;
  }

  // Keys: 'stars:<lang>': Map<String(level) , int(stars)>
  //       'unlocked:<lang>': Set<int> stored as List<int>
  Map<String, dynamic> _starsMap(String lang) =>
      Map<String, dynamic>.from(_box.read('stars:$lang') ?? {});
  List<dynamic> _unlockedList(String lang) =>
      List<dynamic>.from(_box.read('unlocked:$lang') ?? []);

  bool isUnlocked(String lang, int level) {
    if (level == 1) return true;
    // Always unlock test levels for testing purposes
    if (level >= 31 && level <= 40) return true;
    final unlocked = _unlockedList(lang).cast<int>();
    return unlocked.contains(level);
  }

  Future<void> unlock(String lang, int level) async {
    final unlocked = _unlockedList(lang).cast<int>().toSet();
    unlocked.add(level);
    await _box.write('unlocked:$lang', unlocked.toList()..sort());
  }

  Future<void> unlockNextIfNeeded(String lang, int level) async {
    await unlock(lang, level + 1);
  }

  int getStars(String lang, int level) {
    final map = _starsMap(lang);
    final v = map['$level'];
    if (v is int) return v;
    return 0;
  }

  Future<void> setStars(String lang, int level, int stars) async {
    final s = stars.clamp(0, 3);
    final map = _starsMap(lang);
    final current = getStars(lang, level);
    if (s > current) {
      map['$level'] = s;
      await _box.write('stars:$lang', map);
    }
  }

  /// A high-level method to mark a level as complete.
  /// This is the ONLY method controllers should call when a level is finished.
  /// It awards 3 stars and unlocks the next level automatically.
  Future<void> completeLevel(String lang, int level) async {
    // Award 3 stars for completing the level.
    await setStars(lang, level, 3);

    // Unlock the next level.
    await unlock(lang, level + 1);

    // For debugging, you can log the new state.
    print(
      'Completed Level $level for language $lang. Unlocking level ${level + 1}.',
    );
    logUnlocked(lang);
  }

  int totalStars(String lang) {
    final map = _starsMap(lang);
    return map.values.whereType<int>().fold<int>(
      0,
      (sum, v) => sum + v.clamp(0, 3),
    );
  }

  //* for testing
  List<int> getUnlockedLevels(String lang, {bool includeLevel1 = true}) {
    final list = _unlockedList(lang).cast<int>()..sort();
    if (includeLevel1 && !list.contains(1)) {
      list.insert(0, 1);
    }
    return list;
  }

  void logUnlocked(String lang) {
    final levels = getUnlockedLevels(lang);
    print('Unlocked[$lang]: $levels');
  }

  Future<void> unlockAllLevelsForTesting() async {
    const maxLevel = 50; // Generous upper bound to cover all possible levels
    
    for (final lang in ['en', 'fr']) {
      final allLevels = List.generate(maxLevel, (index) => index + 1);
      await _box.write('unlocked:$lang', allLevels);
      
      // Also give 3 stars to all levels for testing
      final starsMap = <String, int>{};
      for (int level = 1; level <= maxLevel; level++) {
        starsMap['$level'] = 3;
      }
      await _box.write('stars:$lang', starsMap);
      
      print('�� UNLOCKED ALL LEVELS FOR TESTING - Language: $lang, Levels: 1-$maxLevel');
    }
  }

  /// FOR TESTING PURPOSES ONLY: Reset all progress
  Future<void> resetAllProgressForTesting() async {
    for (final lang in ['en', 'fr']) {
      await _box.remove('unlocked:$lang');
      await _box.remove('stars:$lang');
    }
    print('🔄 RESET ALL PROGRESS FOR TESTING');
  }
}
