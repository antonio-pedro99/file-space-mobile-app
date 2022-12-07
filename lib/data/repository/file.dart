import 'dart:convert';
import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:space_client_app/data/models/object.dart';

class FileRepository {
  final Dio _dio = Dio();

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
      print("${result.key} Created!");
    } on StorageException catch (e) {
      return {"message": e.message, "status": false};
    }
    return {"key": result.key, "status": true};
  }

  Future<List<PathObject>> loadUserFiles(String userEmail) async {
    String loadUrl = "http://192.168.150.17:8000/user/$userEmail/files/all";
    var result = <PathObject>[];
    try {
      var response = await _dio.get(loadUrl);

      if (response.statusCode == 200) {
        var rawResult = response.data as List<dynamic>;

        result = rawResult.map((e) {
          var json = e as Map<String, dynamic>;
          return PathObject.fromJson(json);
        }).toList();
      }
    } on DioError catch (e) {
      result = jsonDecode(e.error);
    }
    return result;
  }
}
