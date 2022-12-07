import 'dart:convert';
import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:space_client_app/data/models/object.dart';

class FileRepository {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> uploadFile(
      {File? file,
      String? key,
      String? path,
      int? size,
      String? userEmail}) async {
    var result = const TransferProgress(0, 0);
    try {
      var response = await Amplify.Storage.uploadFile(
          local: file!,
          key: "$path/$key",
          options: UploadFileOptions(
              accessLevel: StorageAccessLevel.private, metadata: {}),
          onProgress: (progress) {
            result = progress;
          });
      _updateMetadata(
          DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY)
              .format(await file.lastModified()),
          key,
          path,
          size,
          userEmail,
          false);
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
      {String? key, String? path, String? userEmail}) async {
    var result = UploadFileResult(key: "");
    try {
      final tempDir = await getTemporaryDirectory();
      final tmpFile = File("${tempDir.path}/$key")..createSync();

      result = await Amplify.Storage.uploadFile(
          local: tmpFile,
          key: "$path/$key/",
          options: UploadFileOptions(
              accessLevel: StorageAccessLevel.private, metadata: {}));
      _updateMetadata(
          DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY)
              .format(await tmpFile.lastModified()),
          key,
          path,
          0,
          userEmail,
          true);
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

  Future<void> _updateMetadata(String? modified, String? key, String? path,
      int? size, String? userEmail, bool isFolder) async {
    String url = "http://192.168.150.17:8000/user/update_item";

    try {
      var response = await _dio.post(url,
          data: jsonEncode({
            "is_folder": isFolder,
            "modified": modified,
            "file_name": key,
            "file_extension": key!.split(".").last,
            "file_size": size,
            "file_path": "/$path/$key",
            "user": {"email": userEmail}
          }));

      if (response.statusCode == 200) {
        print("Update!");
      }
    } on DioError catch (e) {
      throw e.message;
    }
  }
}
