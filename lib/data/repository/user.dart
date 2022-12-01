import 'package:amplify_flutter/amplify_flutter.dart';

class UserRepository {
  final List<AuthUserAttribute> user = [];

  Future<void> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();

      user.addAll(result);
    } on AuthException catch (e) {
      throw e.message;
    }
  }
}
