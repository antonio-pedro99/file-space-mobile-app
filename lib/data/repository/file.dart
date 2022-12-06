import 'dart:convert';
import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:space_client_app/data/models/user.dart';

class FileRepository {
  Future<Map<String, dynamic>> uploadFile(
      {File? file, String? key, String? path, UserAuthDetails? user}) async {
    var result = const TransferProgress(0, 0);
    try {
      await Amplify.Storage.uploadFile(
          local: file!,
          key: "$path/$key",
          options: UploadFileOptions(
              accessLevel: StorageAccessLevel.private,
              metadata: {"user": jsonEncode(user!.toMap())}),
          onProgress: (progress) {
            result = progress;
          });
    } on StorageException catch (e) {
      return {"message": e.message, "status": false};
    }
    return {
      "currentBytes": result.currentBytes,
      "total": result.totalBytes,
      "status": true
    };
  }

  Future<Map<String, dynamic>> createFolder(
      {String? folderName, String? path}) async {
    var result = UploadFileResult(key: "");
    try {
      final tempDir = await getTemporaryDirectory();
      final tmpFile = File("${tempDir.path}/$folderName")..createSync();

      result = await Amplify.Storage.uploadFile(
          local: tmpFile,
          key: "$path/$folderName/",
          options: UploadFileOptions(
              accessLevel: StorageAccessLevel.private, metadata: {}));
    } on StorageException catch (e) {
      return {"message": e.message, "status": false};
    }
    return {"key": result.key, "status": true};
  }

  Future<List<StorageItem>> loadFiles() async {
    try {
      final result = await Amplify.Storage.list(
          options: ListOptions(accessLevel: StorageAccessLevel.private));

      return result.items;
    } on StorageException catch (e) {
      rethrow;
    }
  }
}
