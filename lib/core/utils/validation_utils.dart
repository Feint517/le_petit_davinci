class ValidationUtils {
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}\$');
    return regex.hasMatch(email);
  }

  static bool isValidPassword(String password, {int minLength = 6}) {
    return password.length >= minLength;
  }

  static bool isPhoneNumber(String phone) {
    final regex = RegExp(r'^[0-9]{10,15}\$');
    return regex.hasMatch(phone);
  }
}
