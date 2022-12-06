part of 'file_bloc.dart';

@immutable
abstract class FileEvent {}

class FileUpload extends FileEvent {
  final File? file;
  final String? key;
  final String? path;
  final UserAuthDetails? user;

  FileUpload({this.path, this.file, this.key, this.user});
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

class LoadFile extends FileEvent {

}