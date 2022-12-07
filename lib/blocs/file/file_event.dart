part of 'file_bloc.dart';

@immutable
abstract class FileEvent {}

class FileUpload extends FileEvent {
  final File? file;
  final String? key;
  final String? path;

  FileUpload({this.path, this.file, this.key});
}

class FileDownload extends FileEvent {
  final String? key;
  FileDownload({this.key});
}

class CreateFolder extends FileEvent {
  final String? folderName;
  final String? path;
  CreateFolder({this.folderName, this.path});
}

class LoadFiles extends FileEvent {
  final String userEmail;
  LoadFiles(this.userEmail);
}
