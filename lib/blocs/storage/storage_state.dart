part of 'storage_bloc.dart';

@immutable
sealed class StorageState {}

final class StorageInitial extends StorageState {}

final class StorageLoading extends StorageState {}

final class StorageIntegrated extends StorageState {
  final CloudStorage cloudStorage;
  StorageIntegrated(this.cloudStorage);
}

final class StorageDeleted extends StorageState {
  final CloudStorage cloudStorage;

  StorageDeleted(this.cloudStorage);
}

final class StorageError extends StorageState {
  final String message;

  StorageError(this.message);
}

final class StorageAlreadyIntegrated extends StorageState {
  final CloudStorage cloudStorage;

  StorageAlreadyIntegrated(this.cloudStorage);
}

final class StorageFilesLoaded extends StorageState {
  final List<dynamic> files;

  StorageFilesLoaded(this.files);
}