import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:space_client_app/data/models/device.dart';

import 'subscription.dart';

class UserAuthDetails {
  String? email;
  String? name;
  bool? hasSubscription;
  double? quotaUsed;
  double? quotaLimit;
  List<DesktopDevice>? computers;
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
          List<DesktopDevice> devices = [];
          String results = json.decode(json.encode(attr.value));
          var parts = results.substring(2, results.length - 2).split(": ");
          var result =
              parts.map((e) => e.trim().replaceAll(RegExp("'"), '"')).join(":");

          devices.add(DesktopDevice.fromJson(
              json.decode("{$result}") as Map<String, dynamic>));
          computers = devices;
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
