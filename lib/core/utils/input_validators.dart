const String EMAIL_PATTERN =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

class InputValidator {
  ///Returns true if email is valid
  ///Returns false otherwise
  bool validateEmail(String input) {
    String pattern = EMAIL_PATTERN;
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(input);
  }
}
