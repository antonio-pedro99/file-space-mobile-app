import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/blocs/storage/storage_bloc.dart';
import 'package:space_client_app/data/models/cloud_storage.dart';
import 'package:space_client_app/views/page/page_driver.dart';
import 'package:space_client_app/views/page/storage/widgets/storage_tile.dart';

import '../../../blocs/user/user_bloc.dart';

class ConfigStoragePage extends StatefulWidget {
  const ConfigStoragePage({super.key, this.message});

  final String? message;
  @override
  State<ConfigStoragePage> createState() => _ConfigStoragePageState();
}

class _ConfigStoragePageState extends State<ConfigStoragePage> {
  final cloudStorages = CloudStorage.items;
  @override
  Widget build(BuildContext context) {
    var user = context.read<UserBloc>().uDetails;
    return Scaffold(
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                title: const Text("Add Cloud Storage"),
                floating: true,
              )
            ];
          },
          body: MultiBlocListener(
            listeners: [
              // BlocListener<UserBloc, UserState>(
              //   listener: (context, userState) {
              //     if (userState is UserLoading) {

              //     } else if (userState is UserLoaded) {
              //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //           content: Text(
              //         "Upgraded successfully",
              //       )));
              //       Navigator.of(context).pop();
              //     } else if (userState is UserLoadingError) {
              //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //           backgroundColor: Colors.red,
              //           content: Text(
              //             "Failed to upgrade",
              //             style: TextStyle(color: Colors.white),
              //           )));
              //     }
              //   },
              // ),

              /// BlocListener for StorageBloc
              /// Listen for [StorageState] changes
              BlocListener<StorageBloc, StorageState>(
                listener: (context, storageState) {
                  switch (storageState) {
                    case StorageIntegrated():
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const PageDriver()));
                      break;
                    case StorageDeleted():
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        "Removed ${storageState.cloudStorage.cloudStorageName} successfully",
                      )));
                      break;
                    case StorageError():
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                        "Sorry, we something went wrong",
                      )));
                      break;
                    case StorageAlreadyIntegrated():
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        "Storage ${storageState.cloudStorage.cloudStorageName} is already integrated",
                      )));
                      break;
                    default:
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: SizedBox(
                              child:
                                  Center(child: CircularProgressIndicator()))));
                  }
                },
              ),
            ],
            child: SafeArea(
                maintainBottomViewPadding: true,
                top: false,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      Text(
                          widget.message ??
                              "Setup your cloud storage before you proceed",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal)),
                      const SizedBox(
                        height: 24,
                      ),
                      Expanded(
                          child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cloudStorages.length,
                        itemBuilder: (context, index) {
                          var userStorages = user.storages ?? [];

                          var currentStorageIsIntegrated =
                              userStorages.contains(cloudStorages[index].id);
                          return CloudStorageTile(
                            onConnect: () async {
                              await handleStorageIntegration(
                                  cloudStorages[index]);
                            },
                            onDisconnect: () async {
                              await handleStorageDisintegration(
                                  cloudStorages[index]);
                              setState(() {});
                            },
                            cloudStorage: cloudStorages[index],
                            // isIntegrated: currentStorageIsIntegrated,
                          );
                        },
                      ))
                    ],
                  ),
                )),
          )),
    );
  }

  Future<void> handleStorageIntegration(CloudStorage cloudStorage) async {
    switch (cloudStorage.cloudStorageName) {
      case "Google Drive":
        BlocProvider.of<StorageBloc>(context)
            .add(StorageIntegrateEvent(cloudStorage));
        break;
      case "Dropbox":
        break;
      case "One Drive":
        break;
      default:
    }
  }

  Future<void> handleStorageDisintegration(CloudStorage cloudStorage) async {
    switch (cloudStorage.cloudStorageName) {
      case "Google Drive":
        BlocProvider.of<StorageBloc>(context)
            .add(StorageDeleteEvent(cloudStorage));
        break;
      case "Dropbox":
        break;
      case "One Drive":
        break;
      default:
    }
  }
}
