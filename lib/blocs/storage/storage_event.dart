part of 'storage_bloc.dart';

@immutable
sealed class StorageEvent {}

final class StorageInitEvent extends StorageEvent {}

final class StorageIntegrateEvent extends StorageEvent {
  final CloudStorage cloudStorage;

  StorageIntegrateEvent(this.cloudStorage);
}

final class StorageDeleteEvent extends StorageEvent {
  final CloudStorage cloudStorage;

  StorageDeleteEvent(this.cloudStorage);
}

final class StorageFilesEvent extends StorageEvent {
  StorageFilesEvent();
}