import 'package:space_client_app/data/models/subscription.dart';

class User {
  String? email;
  int? quotaLimit;
  int? quotaUsed;
  Subscription? subscriptionPlan;
  User({this.email, this.quotaLimit, this.quotaUsed, this.subscriptionPlan});
}
