import 'package:intl/intl.dart';

class DateUtilsHelper {
  static String formatDate(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
    return DateFormat(pattern).format(date);
  }

  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays > 0) return '${diff.inDays} day(s) ago';
    if (diff.inHours > 0) return '${diff.inHours} hour(s) ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes} minute(s) ago';
    return 'just now';
  }

  static List<String> getWeekDayNames({String locale = 'en_US'}) {
    final now = DateTime.now();
    //? Find the first day of the week (Monday)
    final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return List.generate(7, (index) {
      final day = firstDayOfWeek.add(Duration(days: index));
      return DateFormat.EEEE(locale).format(day); // Full day name, e.g. "lundi"
      //? Use DateFormat.E('fr_FR').format(day) for short names, e.g. "lun"
    });
  }
}
