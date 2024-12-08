class Validators {
  static bool isValidUsername(String username) {
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]{3,50}$');
    return nameRegExp.hasMatch(username);
  }

  static bool isValidEmail(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    // Update RegExp to allow more special characters
    final RegExp passwordRegExp = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:,\.<>?~]).{8,}$');
    return passwordRegExp.hasMatch(password);
  }
}
