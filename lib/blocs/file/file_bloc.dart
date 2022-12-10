import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:space_client_app/data/models/object.dart';
import 'package:space_client_app/data/repository/file.dart';

part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  FileRepository fileOperations = FileRepository();

  FileBloc() : super(FileInitial()) {
    on<FileEvent>((event, emit) async {
      if (event is FileUpload) {
        emit(FileIsUploading());

        var result = await fileOperations.uploadFile(
            file: event.file,
            path: event.path,
            key: event.key,
            size: event.size,
            userEmail: event.userEmail);

        if (result["status"]) {
          emit(FileUploaded());
        } else {
          emit(FileDownUploadError(message: result["message"]));
        }
      } else if (event is FileDownload) {
        emit(FileIsDownloading());

        var result = await fileOperations.downloadFile(event.file!);
        if (result["status"]) {
          emit(FileDownloaded());
        } else {
          emit(FileDownUploadError(message: result["message"]));
        }
      } else if (event is CreateFolder) {
        emit(FileIsUploading());
        var result = await fileOperations.createFolder(
            key: event.folderName!,
            path: event.path,
            userEmail: event.userEmail);

        if (result["status"]) {
          emit(FileUploaded());
        } else {
          emit(FileDownUploadError(message: result["message"]));
        }
      } else if (event is LoadFiles) {
        emit(FileIsLoading());
        var result = await fileOperations.loadUserFiles(event.userEmail);

        emit(FileLoaded(result));
      } else if (event is DeleteFile) {
        emit(FileIsDeleting());
        var result = await fileOperations.deleteFile(event.file);

        if (result["status"]) {
          emit(FileDeleted(result["response"]["message"]));
        } else {
          emit(FileDownUploadError(message: result["message"]));
        }
      } else if (event is UpdateFile) {
        emit(FileIsUpdating());
        var result = {};
        AttributeUpdate atr = AttributeUpdate.none;
        switch (event.attributeUpdate) {
          case AttributeUpdate.link:
            result = await fileOperations.getLink(event.file);
            atr = AttributeUpdate.link;
            break;
          case AttributeUpdate.share:
            break;
          case AttributeUpdate.star:
            result = await fileOperations.addToStarred(event.file);
            atr = AttributeUpdate.star;
            break;
          case AttributeUpdate.none:
            result = await fileOperations.sendCopy(event.file);
            break;
        }
        if (result["status"]) {
          emit(FileUpdated(message: result["message"], attributeUpdate: atr));
        } else {
          emit(FileDownUploadError(message: result["message"]));
        }
      }
    });
  }
}
