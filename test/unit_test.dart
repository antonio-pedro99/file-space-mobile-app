import 'package:flutter_test/flutter_test.dart';
import 'package:space_client_app/app.dart';

void main() {
  group("Test Passwords", () {
    test(": Password is not Strong", () {
      bool isStrong = 'antonio'.isPasswordStrong();

      expect(isStrong, false, reason: "Missing number, capital letter");
    });

    test(": Password is Strong", () {
      bool isStrong = '@AntonioAngola2020'.isPasswordStrong();
      expect(isStrong, true, reason: "Has everything");
    });

    test(": Password is not String", () {
      bool isStrong = '@dev2023'.isPasswordStrong();

      expect(isStrong, false, reason: "Missing 8 chars");
    });
  });

  group("Test Email", () {
    test(": Email is valid", () {
      bool isEmail = 'antonio@gmail.com'.isEmail();
      expect(isEmail, true);
    });
    test(": Is not valid", () {
      bool isEmail = 'antonio'.isEmail();

      expect(isEmail, false);
    });

    test(": Is not valid. Missing @ and domain", () {
      bool isEmail = 'antonio.com'.isEmail();
      expect(isEmail, false);
    });

    test(": Is not valid. Missing domain", () {
      bool isEmail = 'antonio@.com'.isEmail();

      expect(isEmail, false);
    });
  });
}
