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
    return this / 1e+9;
  }

  double toKB() {
    return this / 1024;
  }

  double getSizeFormat() {
    if (this > 0 && this <= math.pow(10, 6)) {
      print("Is KB");
      return toKB();
    } else if (this > math.pow(10, 6) && this <= math.pow(10, 9)) {
      print("is MB");
      return toMB();
    } else if (this > math.pow(10, 9) && this < math.pow(10, 12)) {
      print("is GB");
      return toGB();
    }
    return 0;
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
