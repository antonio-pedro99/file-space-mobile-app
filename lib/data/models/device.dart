class DesktopDevice {
  String? deviceName;
  String? syncFolderName;

  DesktopDevice({this.deviceName, this.syncFolderName});

  DesktopDevice.fromJson(Map<String, dynamic> json) {
    deviceName = json["device"];
    syncFolderName = json["sync_folder"];
  }
}
