import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'subscription.dart';

class UserAuthDetails {
  String? email;
  String? name;
  bool? hasSubscription;
  int? quotaUsed;
  int? quotaLimit;
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
          quotaUsed = int.parse(attr.value);
          break;
        case "custom:limit_quota":
          quotaLimit = int.parse(attr.value);
      }
    }
  }
}

class UserDetails {
  Subscription? subscriptionPlan;
  UserAuthDetails? authDetails;
}
