import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:space_client_app/data/models/subscription.dart';

class UserAuthDetails {
  String? email;
  String? name;
  int? quotaLimit;
  int? quotaUsed;
  Subscription? subscriptionPlan;

  UserAuthDetails(
      {this.email,
      this.quotaLimit,
      this.quotaUsed,
      this.subscriptionPlan,
      this.name});

  UserAuthDetails.fromAttr(List<AuthUserAttribute> attrs) {
    for (var attr in attrs) {
      if (attr.userAttributeKey.key == "email") {
        email = attr.value;
      } else if (attr.userAttributeKey.key == "name") {
        name = attr.value;
      }
    }
  }
}
