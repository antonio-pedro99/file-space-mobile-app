import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
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

  /* UserAuthDetails.fromAttr(List<AuthUserAttribute> attrs) {
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
          if (attr.value.length != 2 || attr.value.isEmpty) {
            String results = json.decode(json.encode(attr.value));
            var parts = results.substring(2, results.length - 2).split(": ");
            var result = parts
                .map((e) => e.trim().replaceAll(RegExp("'"), '"'))
                .join(":");

            devices.add(DesktopDevice.fromJson(
                json.decode("{$result}") as Map<String, dynamic>));
          }
          computers = devices;
          break;
      }
*/

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
  User? user;
  String? id;

  double? quotaUsed;
  double? quotaLimit;
  List<DesktopDevice>? computers;

  UserDetails(
      {this.subscriptionPlan,
      this.user,
      this.id,
      this.quotaLimit = 1024,
      this.quotaUsed = 0.0});

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
        subscriptionPlan: Subscription.fromMap(map["subscription_plan"]),
        user: FirebaseAuth.instance.currentUser,
        quotaUsed: map["quota_used"],
        quotaLimit: map["limit_quota"]);
  }

  toMap(String? name) {
    return {
      "id": id,
      "name": name,
      "email": user!.email,
      "subscription_plan": subscriptionPlan!.toMap(),
      "quota_used": quotaUsed,
      "limit_quota": quotaLimit,
    };
  }
}
