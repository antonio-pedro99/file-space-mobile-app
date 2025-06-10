import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:space_client_app/data/models/cloud_storage.dart';
import 'package:space_client_app/data/models/storage_auth_client.dart';
import 'package:space_client_app/data/repository/drive.dart';
import 'package:space_client_app/data/repository/user.dart';
import 'package:space_client_app/services/user/firebase_user_service.dart';

part 'storage_event.dart';
part 'storage_state.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  GoogleDriveStorageRepository driveRepository;
  StorageAuthClient? storageAuthClient;

  StorageBloc({required this.driveRepository}) : super(StorageInitial()) {
    on<StorageEvent>((event, emit) async {
      emit(StorageLoading());
      switch (event) {
        case StorageIntegrateEvent():
          var driveStorage = CloudStorage.items.firstWhere(
              (element) => element.cloudStorageName == "Google Drive");

          var result = await driveRepository.authorize();

          if (result.isIntegrated!) {
            var userRepo = UserRepository(FirebaseUserService());
            await userRepo.updateStorages(driveStorage.id as String);
            emit(StorageIntegrated(driveStorage));
          } else {
            emit(StorageError("Could not integrate storage"));
          }
        case StorageDeleteEvent():
          var cloud = event.cloudStorage;
          final status = await driveRepository.deauthorize();

          if (status.isIntegrated! == false) {
            // update user's storages
            var userRepo = UserRepository(FirebaseUserService());
            await userRepo.updateStorages(cloud.id as String);
            emit(StorageDeleted(event.cloudStorage));
          } else {
            emit(StorageError("Could not remove storage"));
          }
        case StorageFilesEvent():
          emit(StorageLoading());
          var result = await driveRepository.files();
          
          if (result.status!) {
            emit(StorageFilesLoaded(result.data));
          } else {
            emit(StorageError("Could not load files"));
          }
        default:
          emit(StorageInitial());
      }
    });
  }
}
