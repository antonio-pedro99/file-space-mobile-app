import 'package:flutter/material.dart';
import 'package:space_client_app/views/page/home/enums.dart';
import 'package:googleapis/drive/v3.dart' as drive;

enum GoogleDriveMimeType {
  folder,
  document,
  audio,
  photo,
  file,
  video,
  spreadsheet,
  presentation,
  script,
  form,
  drawing
}

class PathObject {
  String? objectId;
  bool? isFolder;
  String? modified;
  String? fileName;
  String? fileExtension;
  dynamic fileSize;
  bool? isStarred;
  String? filePath;
  bool? hasThumbnail;
  String? thumbnailLink;
  String? driveId;

  PathObject(
      {this.objectId,
      this.isFolder,
      this.modified,
      this.fileName,
      this.fileExtension,
      this.fileSize,
      this.isStarred,
      this.filePath,
      this.hasThumbnail,
      this.thumbnailLink,
      this.driveId});

  PathObject.fromJson(Map<String, dynamic> json) {
    objectId = json['object_id'];
    isFolder = json['is_folder'];
    modified = json['modified'];
    fileName = json['file_name'];
    isStarred = json['is_starred'];
    fileExtension = json['file_extension'];
    fileSize = json['file_size'];
    filePath = json['file_path'];
  }

  PathObject.fromDriveFile(drive.File file) {
    objectId = file.id;
    isFolder = file.mimeType == "application/vnd.google-apps.folder";
    modified = file.modifiedTime.toString();
    fileName = file.name;
    fileExtension = file.fileExtension ?? file.mimeType;
    fileSize = file.size;
    filePath = file.id;
    hasThumbnail = file.hasThumbnail;
    thumbnailLink = file.thumbnailLink;
    driveId = file.driveId;
    isStarred = file.starred;
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
    data['is_starred'] = isStarred;
    return data;
  }
}

extension PathObjectExtension on PathObject {
  FileType getType() {
    print("Extension: $fileExtension");
    if (AppFileSupportedExtensions.media.contains(fileExtension)) {
      if (fileExtension == 'application/vnd.google-apps.photo' ||
          fileExtension == 'image/jpeg' ||
          fileExtension == 'image/png') {
        return FileType.image;
      } else if (fileExtension == 'application/vnd.google-apps.video' ||
          fileExtension == 'video./mp4') {
        return FileType.video;
      } else if (fileExtension == 'application/vnd.google-apps.audio' ||
          fileExtension == 'audio/mp3') {
        return FileType.music;
      } else {
        return FileType.other;
      }
    } else if (AppFileSupportedExtensions.docs.contains(fileExtension)) {
      return FileType.document;
    } else if (AppFileSupportedExtensions.other.contains(fileExtension)) {
      return FileType.other;
    } else if (AppFileSupportedExtensions.folder.contains(fileExtension)) {
      return FileType.folder;
    } else {
      return FileType.other;
    }
  }

  IconData getIcon() {
    switch (getType()) {
      case FileType.music:
        return Icons.music_note;
      case FileType.image:
        return Icons.image;
      case FileType.video:
        return Icons.play_arrow;
      case FileType.document:
        return Icons.insert_drive_file;
      case FileType.other:
        return Icons.insert_drive_file;
      case FileType.folder:
        return Icons.folder;
    }
  }
}
