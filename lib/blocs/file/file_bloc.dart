import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:space_client_app/data/repository/file.dart';

part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  FileRepository fileOperations = FileRepository();

  FileBloc() : super(FileInitial()) {
    on<FileEvent>((event, emit) async {
      if (event is FileUpload) {
        emit(FileIsUploading());

        await fileOperations.uploadFile(
            file: event.file, path: event.path, key: event.key);
        emit(FileUploaded());
      }
    });
  }
}
