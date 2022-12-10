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
  final PathObject? file;
  FileDownload({this.file});
}

class CreateFolder extends FileEvent {
  final String? folderName;
  final String? path;
  final String? userEmail;
  CreateFolder({this.folderName, this.path, this.userEmail});
}

class LoadFiles extends FileEvent {
  final String userEmail;
  LoadFiles(this.userEmail);
}

class LoadFile extends FileEvent {}

class DeleteFile extends FileEvent {
  final PathObject file;
  DeleteFile(this.file);
}

class ShareFile extends FileEvent {
  final PathObject? file;
  ShareFile(this.file);
}

class CopyLinkFile extends FileEvent {
  final PathObject? file;
  CopyLinkFile(this.file);
}

class UpdateFile extends FileEvent {
  final PathObject file;
  final AttributeUpdate attributeUpdate;
  UpdateFile(this.file,this.attributeUpdate);
}

enum AttributeUpdate { link, share, star , none}
