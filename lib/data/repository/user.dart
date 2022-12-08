import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:space_client_app/data/repository/file.dart';

import '../models/user.dart';

class UserRepository {
  final List<AuthUserAttribute> user = [];
  FileRepository fileRepository = FileRepository();

  Future<void> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();

      user.addAll(result);
    } on AuthException catch (e) {
      throw e.message;
    }
  }

  Future<void> updateQuotaUsed(UserAuthDetails user, double val) async {
    try {
      user.quotaUsed = user.quotaUsed! + val;
      final result = await Amplify.Auth.updateUserAttribute(
        userAttributeKey: const CognitoUserAttributeKey.custom('quota_used'),
        value: user.quotaUsed.toString(),
      );
      if (result.isUpdated) {
        print("Updated\n");
      } else {
        print('Update completed');
      }
    } on AmplifyException catch (e) {
      print(e.message);
    }
  }

  Future<void> upgradeQuota(UserAuthDetails user, double quota) async {
    try {
      user.quotaLimit = user.quotaLimit! + quota;
      final result = await Amplify.Auth.updateUserAttribute(
        userAttributeKey: const CognitoUserAttributeKey.custom('limit_quota'),
        value: user.quotaLimit.toString(),
      );
      if (result.isUpdated) {
        print("Updated\n");
      } else {
        print('Update completed');
      }
    } on AmplifyException catch (e) {
      print(e.message);
    }
  }

  Future<void> updateProfilePhoto(UserAuthDetails user, String photoUrl) async {
    try {
      final result = await Amplify.Auth.updateUserAttribute(
        userAttributeKey: const CognitoUserAttributeKey.custom('profile_photo'),
        value: photoUrl,
      );
      if (result.isUpdated) {
        print("Updated\n");
      } else {
        print('Update completed');
      }
    } on AmplifyException catch (e) {
      print(e.message);
    }
  }

  Future<void> updatePhoto() async {}
}
