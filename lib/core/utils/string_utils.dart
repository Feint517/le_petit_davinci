class StringUtils {
  static String capitalize(String s) =>
      s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : s;

  static String truncate(String text, int maxLength) {
    return (text.length <= maxLength) ? text : '${text.substring(0, maxLength)}...';
  }
}
