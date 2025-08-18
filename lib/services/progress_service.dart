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
}
