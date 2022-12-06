import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/blocs/file/file_bloc.dart';
import 'package:space_client_app/blocs/user/user_bloc.dart';
import 'package:space_client_app/views/page/functions.dart';
import 'package:space_client_app/views/page/home/menu.dart';
import 'package:space_client_app/views/page/pages.dart';
import 'package:space_client_app/views/theme/colors.dart';

class PageDriver extends StatefulWidget {
  const PageDriver({Key? key}) : super(key: key);

  @override
  State<PageDriver> createState() => _PageDriverState();
}

class _PageDriverState extends State<PageDriver> {
  List<IconData> icons = [
    Icons.home,
    Icons.star,
    Icons.workspaces,
    Icons.person
  ];

  int currentPage = 0;
  late PageController controller;

  var folderNameTextController = TextEditingController();

  static const String _path = "files";

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentPage);
    folderNameTextController.text = "New Folder";
    //load user data!
    BlocProvider.of<UserBloc>(context).add(LoadUserSession(true));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var showFloatingActionButton =
        MediaQuery.of(context).viewInsets.bottom != 0;
    var user = context.read<UserBloc>();
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(),
      body: BlocConsumer<FileBloc, FileState>(
        listener: (context, state) {
          if (state is FileIsUploading) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    content: SizedBox(
                      height: 50,
                      child: Column(
                        children: const [
                          LinearProgressIndicator(),
                        ],
                      ),
                    ),
                    title: const Text("Uploading your file"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))));
          } else if (state is FileUploaded) {
            Navigator.of(context).pop();
          } else if (state is FileDownUploadError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  state.message!,
                  style: const TextStyle(color: Colors.white),
                )));
          }
        },
        builder: (context, state) {
          return PageView(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            children: AppPages.pages,
            onPageChanged: (v) {
              setState(() => currentPage = v);
            },
          );
        },
      ),
      floatingActionButton: Visibility(
          visible: currentPage != 3 && !showFloatingActionButton,
          child: FloatingActionButton(
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
                                  onTap: () => uploadFile(context, _path),
                                ),
                                ListTile(
                                  leading:
                                      const Icon(Icons.folder_open_outlined),
                                  title: const Text("Create New Folder"),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text(
                                                  "Create new folder"),
                                              content: SizedBox(
                                                  child: TextField(
                                                controller:
                                                    folderNameTextController,
                                                autofocus: true,
                                                decoration: const InputDecoration(
                                                    hintText: "Folder Name",
                                                    prefixIcon:
                                                        Icon(Icons.folder),
                                                    filled: false,
                                                    border:
                                                        OutlineInputBorder()),
                                              )),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              actions: [
                                                TextButton(
                                                    onPressed:
                                                        Navigator.of(context)
                                                            .pop,
                                                    child: Text("Cancel",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                color:
                                                                    lightGrey))),
                                                TextButton(
                                                    onPressed: () {
                                                      createFolder(
                                                          context,
                                                          _path,
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
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
          backgroundColor: blue,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          inactiveColor: grey,
          activeColor: green,
          icons: icons,
          activeIndex: currentPage,
          onTap: (v) {
            setState(() {
              controller.animateToPage(v,
                  duration: const Duration(microseconds: 800),
                  curve: Curves.easeIn);
            });
          }),
    );
  }
}
