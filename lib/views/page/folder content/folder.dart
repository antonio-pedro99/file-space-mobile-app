import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/blocs/file/file_bloc.dart';
import 'package:space_client_app/blocs/user/user_bloc.dart';
import 'package:space_client_app/data/models/object.dart';
import 'package:space_client_app/views/page/functions.dart';
import 'package:space_client_app/views/page/home/widgets/file_tile.dart';
import 'package:space_client_app/views/theme/colors.dart';
import 'package:space_client_app/views/widgets/sort_navigator.dart';

class FolderContentPage extends StatefulWidget {
  const FolderContentPage(
      {Key? key, required this.title, required this.parent, this.userEmail})
      : super(key: key);

  final String title;
  final String parent;
  final String? userEmail;
  @override
  State<FolderContentPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FolderContentPage> {
  var folderNameTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    folderNameTextController.text = "New Folder";
    BlocProvider.of<FileBloc>(context).add(LoadFiles(widget.userEmail!));
    print(widget.parent);
  }

  List<PathObject> _files = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                title: Text(widget.title),
                floating: true,
              )
            ];
          },
          body: SafeArea(
              maintainBottomViewPadding: true,
              top: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        const Icon(Icons.list),
                      ],
                    ),
                    Flexible(
                        child: BlocConsumer<FileBloc, FileState>(
                      listener: (context, state) {
                        if (state is FileLoaded) {
                          _files = state.files
                              .where((element) => element.filePath!.startsWith(
                                  "/${widget.parent}/${widget.title}"))
                              .toList();
                        }
                      },
                      builder: (context, state) {
                        if (state is FileDownUploadError) {
                          return Container(color: Colors.red);
                        } else if (state is FileIsLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                          itemCount: _files.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return FileTile(object: _files[index]);
                          },
                        );
                      },
                    ))
                  ],
                ),
              ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showModalBottomSheet(
              context: context,
              elevation: 3,
              constraints: BoxConstraints(
                  maxHeight: size.height * .25, minWidth: size.width),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24))),
              builder: (context) {
                return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Add to SpaceFile"),
                        const SizedBox(
                          height: 24,
                        ),
                        Flexible(
                            child: ListView(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.note_add_outlined),
                              title: const Text("Upload a File"),
                              onTap: () => uploadTest(
                                  context, "${widget.parent}/${widget.title}"),
                            ),
                            ListTile(
                              leading: const Icon(Icons.folder_open_outlined),
                              title: const Text("Create New Folder"),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title:
                                              const Text("Create new folder"),
                                          content: SizedBox(
                                              child: TextField(
                                            controller:
                                                folderNameTextController,
                                            autofocus: true,
                                            decoration: const InputDecoration(
                                                hintText: "Folder Name",
                                                prefixIcon: Icon(Icons.folder),
                                                filled: false,
                                                border: OutlineInputBorder()),
                                          )),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          actions: [
                                            TextButton(
                                                onPressed:
                                                    Navigator.of(context).pop,
                                                child: Text("Cancel",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: lightGrey))),
                                            TextButton(
                                                onPressed: () {
                                                  createFolder(
                                                      context,
                                                      "${widget.parent}/${widget.title}",
                                                      folderNameTextController
                                                          .text);
                                                },
                                                child: const Text("Create"))
                                          ],
                                        ));
                              },
                            ),
                            ListTile(
                                leading: const Icon(Icons.upload_file),
                                title: const Text("Upload from Computer"),
                                onTap: () {})
                          ],
                        ))
                      ],
                    ));
              });
        },
        tooltip: 'Open Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
