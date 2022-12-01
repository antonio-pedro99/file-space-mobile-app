import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:space_client_app/app.dart';

import 'subscription.dart';

class UserAuthDetails {
  String? email;
  String? name;
  bool? hasSubscription;
  double? quotaUsed;
  double? quotaLimit;
  UserAuthDetails({this.email, this.name, this.quotaLimit, this.quotaUsed});

  UserAuthDetails.fromAttr(List<AuthUserAttribute> attrs) {
    for (var attr in attrs) {
      switch (attr.userAttributeKey.key) {
        case "email":
          email = attr.value;
          break;
        case "name":
          name = attr.value;
          break;
        case "custom:quota_used":
          quotaUsed = double.parse(attr.value);
          break;
        case "custom:limit_quota":
          quotaLimit = double.parse(attr.value);
      }
    }
  }

  Future<void> updateQuotaUsed(double val) async {
    try {
      quotaUsed = quotaUsed! + val;
      final result = await Amplify.Auth.updateUserAttribute(
        userAttributeKey: const CognitoUserAttributeKey.custom('quota_used'),
        value: quotaUsed.toString(),
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

  Future<void> upgradeQuota(double quota) async {
    try {
      quotaLimit = quotaLimit! + quota;
      final result = await Amplify.Auth.updateUserAttribute(
        userAttributeKey: const CognitoUserAttributeKey.custom('limit_quota'),
        value: quotaLimit.toString(),
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

  String getTotalSpacePercentage() {
    var used = quotaUsed! / quotaLimit! * 100;
    return used.toStringAsFixed(2);
  }
}

class UserDetails {
  Subscription? subscriptionPlan;
  UserAuthDetails? authDetails;
}
