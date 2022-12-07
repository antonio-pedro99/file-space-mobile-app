import 'package:space_client_app/views/page/home/enums.dart';

class PathObject {
  String? objectId;
  bool? isFolder;
  String? modified;
  String? fileName;
  String? fileExtension;
  int? fileSize;
  String? filePath;

  PathObject(
      {this.objectId,
      this.isFolder,
      this.modified,
      this.fileName,
      this.fileExtension,
      this.fileSize,
      this.filePath});

  PathObject.fromJson(Map<String, dynamic> json) {
    objectId = json['object_id'];
    isFolder = json['is_folder'];
    modified = json['modified'];
    fileName = json['file_name'];
    fileExtension = json['file_extension'];
    fileSize = json['file_size'];
    filePath = json['file_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['object_id'] = objectId;
    data['is_folder'] = isFolder;
    data['modified'] = modified;
    data['file_name'] = fileName;
    data['file_extension'] = fileExtension;
    data['file_size'] = fileSize;
    data['file_path'] = filePath;
    return data;
  }
}

extension GetPathType on PathObject {
  FileType getType() {
    switch (fileExtension) {
      case "mp3":
        return FileType.music;
      case "png":
      case "jpeg":
      case "jpg":
        return FileType.image;
      case "mp4":
      case "mov":
      case "avi":
        return FileType.video;
      case "folder":
        return FileType.folder;
      default:
        return FileType.document;
    }
  }
}
