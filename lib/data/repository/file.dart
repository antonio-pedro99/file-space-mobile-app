import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';

class FileRepository {
  Future<void> uploadFile({File? file, String? key, String? path}) async {
    try {
      await Amplify.Storage.uploadFile(
          local: file!,
          key: "$path/$key",
          options: UploadFileOptions(
              accessLevel: StorageAccessLevel.private, metadata: {}),
          onProgress: (progress) {});
    } on StorageException catch (e) {
      print("Error $e");
    }
  }
}
