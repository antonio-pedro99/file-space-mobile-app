library clipboard;

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:space_client_app/data/models/object.dart';
import 'package:space_client_app/data/repository/user.dart';

class FileRepository {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> uploadFile(
      {File? file,
      String? key,
      String? path,
      int? size,
      String? userEmail}) async {
    /*  var result = const TransferProgress(0, 0);
    try {
      await Amplify.Storage.uploadFile(
          local: file!,
          key: "$path/$key",
          options: UploadFileOptions(
            accessLevel: StorageAccessLevel.protected,
          ),
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
    } */
    return {"currentBytes": 0, "total": 0, "status": true};
  }

  Future<Map<String, dynamic>> createFolder(
      {String? key, String? path, String? userEmail}) async {
    /*  var result = UploadFileResult(key: "");
    try {
      final tempDir = await getTemporaryDirectory();
      final tmpFile = File("${tempDir.path}/$key")..createSync();

      result = await Amplify.Storage.uploadFile(
          local: tmpFile,
          key: "$path/$key/",
          options: UploadFileOptions(
              accessLevel: StorageAccessLevel.protected, metadata: {}));
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
    } */
    return {"key": "key", "status": true};
  }

  Future<List<PathObject>> loadUserFiles(String userEmail) async {
    String _id = await UserRepository.fetchCognitoUserId();
    String loadUrl = "http://18.188.244.88/user/$_id&$userEmail/files/all";
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
    } on DioException catch (e) {
      result = e.message as List<PathObject>;
    }
    return result;
  }

  Future<void> _updateMetadata(String? modified, String? key, String? path,
      int? size, String? userEmail, bool isFolder) async {
    String url = "http://18.188.244.88/user/update_item";

    try {
      var response = await _dio.post(url,
          data: jsonEncode({
            "is_folder": isFolder,
            "modified": modified,
            "file_name": key,
            "file_extension": !isFolder ? key!.split(".").last : "folder",
            "file_size": size,
            "file_path": "/$path/",
            "is_starred": false,
            "access_list": [
              {
                "email": userEmail,
                "id": await UserRepository.fetchCognitoUserId()
              }
            ],
            "user": {
              "email": userEmail,
              "id": await UserRepository.fetchCognitoUserId()
            }
          }));

      if (response.statusCode == 200) {}
    } on DioException catch (e) {
      throw e.message as String;
    }
  }

  //share

  //get link
  Future<Map<String, dynamic>> getLink(PathObject file) async {
    var result = <String, dynamic>{};
    /*  try {
      var key = "${file.filePath!.substring(1)}${file.fileName}";
      final response = await Amplify.Storage.getUrl(
          key: file.isFolder! ? "$key/" : key,
          options: GetUrlOptions(accessLevel: StorageAccessLevel.protected));

      _copyToClipBoard(response.url);
      result["message"] = "Link Copied to clipboard";
      result["status"] = true;
    } on StorageException catch (e) {
      return {"message": e.message, "status": false};
    } */
    return result;
  }

  //add to workspace

  //add to starred
  Future<Map<String, dynamic>> addToStarred(PathObject file) async {
    String url = "http://18.188.244.88/star_file";
    var result = <String, dynamic>{};
    try {
      var response = await _dio.put(url,
          data: {"object_id": file.objectId, "is_starred": !file.isStarred!});

      if (response.statusCode == 200) {
        result = response.data as Map<String, dynamic>;
        result["status"] = true;
      }
    } on DioError catch (e) {
      result["message"] = e.message;
    }

    return result;
  }

  //download

  Future<Map<String, dynamic>> downloadFile(PathObject file) async {
    final tempDir = await getTemporaryDirectory();
    final tmpFile = File("${tempDir.path}/${file.fileName}")..createSync();

    /*  var result = const TransferProgress(0, 0);

    try {
      await Permission.manageExternalStorage.request();
      
      await Amplify.Storage.downloadFile(
          key: "${file.filePath!.substring(1)}${file.fileName}",
          local: tmpFile,
          options:
              DownloadFileOptions(accessLevel: StorageAccessLevel.protected),
          onProgress: (progress) {
            result = progress;
          });

      tmpFile.copy("/storage/emulated/0/Download/${file.fileName}");
    } on StorageException catch (e) {
      return {"message": e.message, "status": false};
    } */
    return {"currentBytes": 0, "total": 0, "status": true};
  }

  //send a copy
  Future<Map<String, dynamic>> sendCopy(PathObject file) async {
    final tempDir = await getTemporaryDirectory();
    final tmpFile = File("${tempDir.path}/${file.fileName}")..createSync();

    /* try {
      await Permission.manageExternalStorage.request();
      await Amplify.Storage.downloadFile(
        key: "${file.filePath!.substring(1)}${file.fileName}",
        local: tmpFile,
        options: DownloadFileOptions(accessLevel: StorageAccessLevel.protected),
      );
    } on StorageException catch (e) {
      return {"message": e.message, "status": false};
    } */

    return {"message": tmpFile.path, "status": true};
  }

  //delete
  Future<Map<String, dynamic>> deleteFile(PathObject file) async {
    /*   try {
      var key = "${file.filePath!.substring(1)}${file.fileName}";
      final result = await Amplify.Storage.remove(
          key: file.isFolder! ? "$key/" : key,
          options: RemoveOptions(accessLevel: StorageAccessLevel.protected));
      safePrint(result.key);
    } on StorageException catch (e) {
      return {"message": e.message, "status": false};
    } */
    return {"status": true, "response": await _deleteFile(file.objectId!)};
  }

  Future<Map<String, dynamic>> _deleteFile(String objectId) async {
    String url = "http://18.188.244.88/user/delete_item";
    var result = <String, dynamic>{};
    /* try {
      var response = await _dio.delete("$url/$objectId");

      if (response.statusCode == 200) {
        result = response.data as Map<String, dynamic>;
      }
    } on DioError catch (e) {
      throw e.message;
    } */
    return result;
  }
}

Future<void> _copyToClipBoard(String text) async {
  if (text.isNotEmpty) {
    await Clipboard.setData(ClipboardData(text: text));
  }
}
