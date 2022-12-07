import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/extensions.dart';
import 'package:space_client_app/blocs/file/file_bloc.dart';

import '../../blocs/user/user_bloc.dart';

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

void pickFileFromOs(BuildContext context, String path) {
  var user = context.read<UserBloc>();
  FilePicker.platform.pickFiles().then((result) async {
    if (result != null) {
      final platformFile = result.files.single;
      final _path = platformFile.path!;
      final key = platformFile.name;
      final file = File(_path);

      try {
        if (user.user.quotaUsed! + platformFile.size.toDouble().toMB() <
            user.user.quotaLimit!) {
          await Amplify.Storage.uploadFile(
              local: file,
              key: "$path/$key",
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
        }
        await user.user.updateQuotaUsed(platformFile.size.toDouble().toMB());
      } on StorageException catch (e) {
        print("Error $e");
      }
    } else {
      print("Cant");
    }
  });
}

Future<void> createFolder(
    BuildContext context, String path, String folderName) async {
  var user = context.read<UserBloc>();
  BlocProvider.of<FileBloc>(context).add(CreateFolder(
      path: path, folderName: folderName, userEmail: user.user.email));
  Navigator.of(context).pop();
}

void uploadTest(BuildContext context, String path) {
  var user = context.read<UserBloc>();

  FilePicker.platform.pickFiles().then((result) async {
    if (result != null) {
      final platformFile = result.files.single;
      final _path = platformFile.path!;
      final key = platformFile.name;
      final file = File(_path);

      if (user.user.quotaUsed! + platformFile.size.toDouble().toMB() <
          user.user.quotaLimit!) {
        BlocProvider.of<FileBloc>(context).add(FileUpload(
            file: file,
            path: path,
            key: key,
            size: platformFile.size,
            userEmail: user.user.email));
      }
      await user.user.updateQuotaUsed(platformFile.size.toDouble().toMB());
    } else {
      print("Cant");
    }
  });
}
