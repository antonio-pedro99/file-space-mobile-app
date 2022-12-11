import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'subscription.dart';

class UserAuthDetails {
  String? email;
  String? name;
  bool? hasSubscription;
  double? quotaUsed;
  double? quotaLimit;
  List<dynamic>? computers;
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
          break;
        case "custom:desktop":
          computers = json.decode(attr.value) as List<dynamic>;
          break;
      }
    }
  }
  String getTotalSpacePercentage() {
    var used = quotaUsed! / quotaLimit! * 100;
    return used.toStringAsFixed(2);
  }

  toMap() {
    return {
      "email": email,
      "name": name,
      "quota_used": quotaUsed,
      "limit_quota": quotaLimit,
      "desktop": json.encode(computers)
    };
  }
}

class UserDetails {
  Subscription? subscriptionPlan;
  UserAuthDetails? authDetails;
}
