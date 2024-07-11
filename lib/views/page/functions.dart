library clipboard;

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:space_client_app/blocs/file/file_bloc.dart';
import 'package:space_client_app/data/models/object.dart';
import 'package:space_client_app/extensions.dart';

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
  var user = context.read<UserBloc>();

  // BlocProvider.of<FileBloc>(context).add(CreateFolder(
  //     path: path, folderName: folderName, userEmail: user.user.email));
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

      // if (user.user.quotaUsed! + platformFile.size.toDouble().toMB() <
      //     user.user.quotaLimit!) {
      //   BlocProvider.of<FileBloc>(context).add(FileUpload(
      //       file: file,
      //       path: path,
      //       key: key,
      //       size: platformFile.size,
      //       userEmail: user.user.email));
      // }
      await Future.delayed(const Duration(seconds: 2));
    }
  });
}

void deleteFile(BuildContext context, PathObject file) async {
  var user = context.read<UserBloc>();

  BlocProvider.of<FileBloc>(context).add(DeleteFile(file));
  Navigator.of(context).pop();
  await Future.delayed(const Duration(seconds: 2));
}

void starFile(BuildContext context, PathObject file) async {
  var user = context.read<UserBloc>();

  BlocProvider.of<FileBloc>(context).add(DeleteFile(file));
  Navigator.of(context).pop();
  await Future.delayed(const Duration(seconds: 2));
}

String getParentPath(String path) =>
    path.split("/").firstWhere((element) => element.isNotEmpty);
