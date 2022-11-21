import 'package:space_client_app/data/models/object.dart';

class MockRepository {
  static List<PathObject> getAllFiles() {
    return [
      PathObject(
          fileName: "TRX Vou bazar",
          fileSize: 30,
          fileExtension: "mp3",
          modified: "11:30 AM",
          filePath: "",
          isFolder: true),
      PathObject(
          fileName: "Musics",
          fileSize: 0,
          fileExtension: "folder",
          modified: "11:30 AM",
          filePath: "",
          isFolder: true),
      PathObject(
          fileName: "Preview",
          fileSize: 30,
          fileExtension: "jpeg",
          modified: "11:30 AM",
          filePath: "",
          isFolder: false),
      PathObject(
          fileName: "MOC 12/11/22",
          fileSize: 1024,
          fileExtension: "jpg",
          modified: "11:30 AM",
          filePath: "",
          isFolder: false),
      PathObject(
          fileName: "T-Rex-Verdadeiro Feel",
          fileSize: 30,
          fileExtension: "mp3",
          modified: "11:30 AM",
          filePath: "",
          isFolder: false),
      PathObject(
          fileName: "Curso em video",
          fileSize: 30,
          fileExtension: "avi",
          modified: "11:30 AM",
          filePath: "",
          isFolder: false),
      PathObject(
          fileName: "Images",
          fileSize: 30,
          fileExtension: "folder",
          modified: "11:30 AM",
          filePath: "",
          isFolder: true),
      PathObject(
          fileName: "CN_assignment2",
          fileSize: 30,
          fileExtension: "doc",
          modified: "11:30 AM",
          filePath: "",
          isFolder: false),
    ];
  }
}
