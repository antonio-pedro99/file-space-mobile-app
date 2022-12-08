import 'dart:math' as math;

extension PasswordChecker on String {
  bool isPasswordStrong() {
    var strongPattern = RegExp(
        r'(?=^.{8,}$)(?=.*\d)(?=.*[!@#$%^&*]+)(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$');
    var awsPattern = RegExp(r'^[\S]+.*[\S]+$');
    return strongPattern.hasMatch(this) && awsPattern.hasMatch(this);
  }
}

extension EmailChecker on String {
  bool isEmail() {
    var emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailPattern.hasMatch(this);
  }
}

extension MBConverter on double {
  double toMB() {
    return this / 1e+6;
  }

  double toGB() {
    return this / 1024;
  }

  double toKB() {
    return this / 1024;
  }

  Map<double, String> getSizeFormat() {
    if (this > 0 && this <= math.pow(10, 6)) {
      return {toKB(): "KB"};
    } else if (this > math.pow(10, 6) && this <= math.pow(10, 9)) {
      return {toMB(): "MB"};
    } else if (this > math.pow(10, 9) && this < math.pow(10, 12)) {
      return {toGB(): "GB"};
    }
    return {0: ""};
  }
}

extension FileDynamicType on String {
  bool isFolder() {
    return contains("/");
  }

  String getFolderName() {
    return split('/').lastWhere((element) => element.isNotEmpty);
  }
}
