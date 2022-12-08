part of 'file_bloc.dart';

@immutable
abstract class FileEvent {}

class FileUpload extends FileEvent {
  final File? file;
  final String? key;
  final String? path;
  final int? size;
  final String? userEmail;
  FileUpload({this.path, this.file, this.key, this.size, this.userEmail});
}

class FileDownload extends FileEvent {
  final String? key;
  FileDownload({this.key});
}

class CreateFolder extends FileEvent {
  final String? folderName;
  final String? path;
  final String? userEmail;
  CreateFolder({this.folderName, this.path,this.userEmail});
}

class LoadFiles extends FileEvent {
  final String userEmail;
  LoadFiles(this.userEmail);
}

class LoadFile extends FileEvent {

}