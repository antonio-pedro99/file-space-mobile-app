import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:path_provider/path_provider.dart';

class FileRepository {
  Future<Map<String, dynamic>> uploadFile(
      {File? file, String? key, String? path}) async {
    var result = const TransferProgress(0, 0);
    try {
      await Amplify.Storage.uploadFile(
          local: file!,
          key: "$path/$key",
          options: UploadFileOptions(
              accessLevel: StorageAccessLevel.private, metadata: {}),
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
}
