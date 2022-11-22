import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void openModalBottomSheet(BuildContext context, Widget content) {
  var size = MediaQuery.of(context).size;

  showModalBottomSheet(
      context: context,
      elevation: 3,
      constraints:
          BoxConstraints(maxHeight: size.height * .25, minWidth: size.width),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      builder: (context) {
        return content;
      });
}

void pickFileFromOs(BuildContext context) {
  FilePicker.platform.pickFiles().then((result) async {
    if (result != null) {
      final platformFile = result.files.single;
      final path = platformFile.path!;
      final key = platformFile.name;
      final file = File(path);
      try {
        await Amplify.Storage.uploadFile(
            local: file,
            key: key,
            options: UploadFileOptions(
                accessLevel: StorageAccessLevel.private, metadata: {}),
            onProgress: (progress) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      content: SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            LinearProgressIndicator(
                              value: progress.getFractionCompleted(),
                            ),
                            Text(progress.currentBytes.toString())
                          ],
                        ),
                      ),
                      title: const Text("Uploading your file"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))));
            });
        print("Uploaded the file");
      } on StorageException catch (e) {
        print("Error $e");
      }
    } else {
      print("Cant");
    }
  });

  /* Navigator.of(context).pop(); */
}
