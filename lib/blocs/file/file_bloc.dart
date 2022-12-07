import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:space_client_app/data/models/object.dart';
import 'package:space_client_app/data/models/user.dart';
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
      } else if (event is CreateFolder) {
        emit(FileIsUploading());
        var result = await fileOperations.createFolder(
            key: event.folderName!, path: event.path, userEmail: event.userEmail);

        if (result["status"]) {
          emit(FileUploaded());
        } else {
          emit(FileDownUploadError(message: result["message"]));
        }
      } else if (event is LoadFiles) {
        emit(FileIsLoading());
        var result = await fileOperations.loadUserFiles(event.userEmail);

        emit(FileLoaded(result));
      }
    });
  }
}
