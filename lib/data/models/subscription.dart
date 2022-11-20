class Subscription {
  final String? subScriptionName;
  final List<String>? features;
  final double? price;
  final double? storage;
  final bool? isCurrent;

  Subscription(
      {this.features,
      this.isCurrent,
      this.price,
      this.storage,
      this.subScriptionName});
}
