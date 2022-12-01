part of 'file_bloc.dart';

@immutable
abstract class FileState {}

class FileInitial extends FileState {}

class FileIsUploading extends FileState {}

class FileIsDownloading extends FileState {}

class FileDownloaded extends FileState {}

class FileUploaded extends FileState {}

class FileDownUploadError extends FileState {
  final String? message;

  FileDownUploadError({this.message});
}
