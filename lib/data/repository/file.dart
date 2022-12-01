import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';

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
      print("Uploaded\n");
    } on StorageException catch (e) {
      return {"message": e.message, "status": false};
    }
    return {
      "currentBytes": result.currentBytes,
      "total": result.totalBytes,
      "status": true
    };
  }
}
