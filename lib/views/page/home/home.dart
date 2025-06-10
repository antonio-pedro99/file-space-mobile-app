import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/blocs/file/file_bloc.dart';
import 'package:space_client_app/blocs/storage/storage_bloc.dart';
import 'package:space_client_app/blocs/user/user_bloc.dart';
import 'package:space_client_app/data/models/cloud_storage.dart';
import 'package:space_client_app/data/models/object.dart';
import 'package:space_client_app/views/page/functions.dart';
import 'package:space_client_app/views/page/home/widgets/cloud_storage_tile.dart';
import 'package:space_client_app/views/page/home/widgets/file_tile.dart';
import 'package:space_client_app/views/page/home/widgets/grid_file_tile.dart';
import 'package:space_client_app/views/theme/colors.dart';
import 'package:space_client_app/views/widgets/input_text.dart';
import 'package:space_client_app/views/widgets/sort_navigator.dart';
import 'package:googleapis/drive/v3.dart' as drive;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isList = true;

  var _files = [];
  var storages = CloudStorage.items;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var userDetails = context.read<UserBloc>().uDetails;

    return Scaffold(
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                title: const Text("Home"),
                floating: true,
              )
            ];
          },
          body: BlocConsumer<StorageBloc, StorageState>(
            listener: (context, state) {
              print(state);
              switch (state) {
                case StorageFilesLoaded():
                  _files = state.files.map((file) {
                    if (file is drive.File) {
                      return PathObject.fromDriveFile(file);
                    }
                  }).toList();
                  break;
                case StorageError():
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Error loading files")));
                  break;
                default:
              }
            },
            builder: (context, state) {
              var storages = CloudStorage.items.where(
                  (storage) => userDetails.storages!.contains(storage.id));

              if (state is StorageLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return SafeArea(
                  maintainBottomViewPadding: true,
                  top: false,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTextInput(
                          hint: "Search for anything",
                          leading: Icons.search,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          child: Wrap(
                            children: storages
                                .map((e) => HomeCloudStorageTile(e))
                                .toList(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextButton.icon(
                                onPressed: () {
                                  openModalBottomSheet(
                                      context,
                                      const SortNavigator(
                                        title: "Sort by",
                                      ));
                                },
                                icon: const Icon(Icons.keyboard_arrow_down,
                                    color: lightGrey),
                                label: Text(
                                  "Recent Files",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() => isList = !isList);
                              },
                              icon: Icon(
                                  !isList ? Icons.list : Icons.view_column),
                            )
                          ],
                        ),
                        Flexible(
                            child: state is FileIsLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : !isList
                                    ? GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 180,
                                          childAspectRatio: 3 / 4,
                                        ),
                                        itemCount: _files.length,
                                        itemBuilder: (context, index) {
                                          return GridFileTile(
                                              object: _files[index]);
                                        })
                                    : ListView.builder(
                                        itemCount: _files.length,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return FileTile(
                                              object: _files[index]);
                                        },
                                      ))
                      ],
                    ),
                  ));
            },
          )),
    );
  }
}
