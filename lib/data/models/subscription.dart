class Subscription {
  final String? subScriptionName;
  final List<String>? features;
  final double? price;
  final double? storage;
  final int? quotaLimit;
  final bool? isCurrent;

  Subscription(
      {this.features,
      this.isCurrent = true,
      this.price = 0.0,
      this.storage = 1024,
      this.quotaLimit = 1024,
      this.subScriptionName = "Basic"});


  factory Subscription.fromMap(Map<String, dynamic> map) {

    return Subscription(
        subScriptionName: map["subscription_name"],
        features: (map["features"] as List<dynamic>).map((e) => e.toString()).toList(),
        price: map["price"],
        storage: map["storage"],
        quotaLimit: map["quota_limit"],
        isCurrent: map["is_current"]);
  }
  
  toMap() {
    return {
      "subscription_name": subScriptionName,
      "features": features,
      "price": price,
      "storage": storage,
      "quota_limit": quotaLimit,
      "is_current": isCurrent
    };
  }
}
