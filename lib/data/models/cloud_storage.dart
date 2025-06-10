class CloudStorage {
  final String? id;
  final String? cloudStorageName;
  final List<String>? features;
  bool? isIntegrated;
  final String? icon;

  CloudStorage(
      {this.features,
      this.id,
      this.isIntegrated = true,
      this.icon,
      this.cloudStorageName = "Google Drive"});

  factory CloudStorage.fromMap(Map<String, dynamic> map) {
    return CloudStorage(
        id: map["id"],
        cloudStorageName: map["CloudStorage_name"],
        features: (map["features"] as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        icon: map["icon"],
        isIntegrated: map["is_integrated"]);
  }

  toMap() {
    return {
      "id": id,
      "cloudStorage_name": cloudStorageName,
      "features": features,
      "is_integrated": isIntegrated,
      "icon": icon
    };
  }

  static List<CloudStorage> items = [
    CloudStorage(
        features: [
          "Store around3 300 photos",
          "Backup photos automatically",
          "Access any device"
        ],
        isIntegrated: false,
        cloudStorageName: "Google Drive",
        id: "1",
        icon: "assets/icons/googledrive.svg"),
    CloudStorage(
        features: [
          "Store around3 300 photos",
          "Backup photos automatically",
          "Access any device"
        ],
        isIntegrated: false,
        cloudStorageName: "One Drive",
        id: "2",
        icon: "assets/icons/onedrive.svg"),
    CloudStorage(
        features: [
          "Store around3 300 photos",
          "Backup photos automatically",
          "Access any device"
        ],
        isIntegrated: false,
        cloudStorageName: "Dropbox",
        id: "3",
        icon: "assets/icons/dropbox.svg"),
  ];
}
