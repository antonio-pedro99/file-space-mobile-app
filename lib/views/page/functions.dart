import 'dart:io';
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

Future<void> createFolder(
    BuildContext context, String path, String folderName) async {
  BlocProvider.of<FileBloc>(context)
      .add(CreateFolder(path: path, folderName: folderName));
  Navigator.of(context).pop();
}

void uploadFile(BuildContext context, String path) {
  var user = context.read<UserBloc>();

  FilePicker.platform.pickFiles().then((result) async {
    if (result != null) {
      final platformFile = result.files.single;
      final _path = platformFile.path!;
      final key = platformFile.name;
      final file = File(_path);

      if (user.user.quotaUsed! + platformFile.size.toDouble().toMB() <
          user.user.quotaLimit!) {
        BlocProvider.of<FileBloc>(context)
            .add(FileUpload(file: file, path: path, key: key));
      }
      await user.userAttr
          .updateQuotaUsed(user.user, platformFile.size.toDouble().toMB());
    } else {
      print("Cant");
    }
  });
}
