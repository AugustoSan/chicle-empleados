class StringUtil {
  static String osbcureText(String text) {
    return '*' * text.length;
  }
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
  static String truncateWithEllipsis(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength - 3) + '...';
  }
  static String removeWhitespace(String text) {
    return text.replaceAll(RegExp(r'\s+'), '');
  }
  static String hideMiddle(String text) {
    if (text.length <= 4) return text;
    final start = text.substring(0, 4);
    final end = text.substring(text.length - 4);
    return '$start****$end';
  }
}