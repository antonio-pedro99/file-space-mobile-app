import 'package:flutter/material.dart';
import 'package:space_client_app/data/models/object.dart';
import 'package:space_client_app/data/repository/mock_data.dart';
import 'package:space_client_app/views/page/functions.dart';
import 'package:space_client_app/views/page/home/enums.dart';
import 'package:space_client_app/views/page/home/widgets/category_tile.dart';
import 'package:space_client_app/views/page/home/widgets/file_tile.dart';
import 'package:space_client_app/views/page/home/widgets/grid_file_tile.dart';
import 'package:space_client_app/views/page/shared/shared.dart';
import 'package:space_client_app/views/theme/colors.dart';
import 'package:space_client_app/views/widgets/input_text.dart';
import 'package:space_client_app/views/widgets/sort_navigator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isList = true;

  /* List<Widget> selectFiles() {
    if (isList) {
      return [
        FileTile(
          object: PathObject(
              fileName: "TRX Vou bazar",
              fileSize: 30,
              fileExtension: "folder",
              modified: "11:30 AM",
              filePath: "",
              isFolder: true),
        ),
        const SizedBox(height: 8),
       
      ];
    } else {
      return const [
        GridFileTile(name: "Preview.mp3", size: "30 KB", type: FileType.music),
        GridFileTile(name: "Preview.png", size: "30 KB", type: FileType.image),
        GridFileTile(name: "Preview.png", size: "30 KB", type: FileType.video),
        GridFileTile(
            name: "Preview.png", size: "30 KB", type: FileType.document),
        GridFileTile(name: "Preview.png", size: "30 KB", type: FileType.image),
        GridFileTile(name: "Preview.png", size: "30 KB", type: FileType.image),
        GridFileTile(name: "Assignments", size: "30 KB", type: FileType.folder),
        GridFileTile(name: "Preview.png", size: "30 KB", type: FileType.music),
        GridFileTile(name: "Videos", size: "30 KB", type: FileType.folder),
        GridFileTile(name: "Preview.png", size: "30 KB", type: FileType.image),
        GridFileTile(name: "Preview.png", size: "30 KB", type: FileType.image),
        GridFileTile(name: "Preview.png", size: "30 KB", type: FileType.image),
        GridFileTile(name: "Preview.png", size: "30 KB", type: FileType.video),
        GridFileTile(name: "Preview.png", size: "30 KB", type: FileType.video),
        GridFileTile(
            name: "Preview.png", size: "30 KB", type: FileType.document),
        GridFileTile(name: "Preview.png", size: "30 KB", type: FileType.other)
      ];
    } 
  } */

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
                title: const Text("Home"),
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
                    const CustomTextInput(
                      hint: "Search for anything",
                      leading: Icons.search,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CategoryTile(
                            category: "All",
                            icon: Icons.apps_rounded,
                            color: deepPurple,
                          ),
                          const CategoryTile(
                              category: "Folders",
                              icon: Icons.folder_rounded,
                              color: green),
                          const CategoryTile(
                              category: "Files",
                              icon: Icons.insert_drive_file_rounded,
                              color: blueOcean),
                          CategoryTile(
                            category: "Shared",
                            icon: Icons.folder_shared_rounded,
                            color: purple,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SharedPage()));
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
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
                          icon: Icon(!isList ? Icons.list : Icons.view_column),
                        )
                      ],
                    ),
                    Flexible(
                        child: !isList
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 180,
                                  childAspectRatio: 3 / 4,
                                ),
                                itemCount: MockRepository.getAllFiles().length,
                                itemBuilder: (context, index) {
                                  return GridFileTile(
                                      object:
                                          MockRepository.getAllFiles()[index]);
                                })
                            : ListView.builder(
                                itemCount: MockRepository.getAllFiles().length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return FileTile(
                                      object:
                                          MockRepository.getAllFiles()[index]);
                                },
                              ))
                  ],
                ),
              ))),
    );
  }
}
