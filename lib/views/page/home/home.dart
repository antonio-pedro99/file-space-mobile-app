import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/blocs/file/file_bloc.dart';
import 'package:space_client_app/blocs/user/user_bloc.dart';
import 'package:space_client_app/data/models/object.dart';
import 'package:space_client_app/views/page/category%20content/content.dart';
import 'package:space_client_app/views/page/functions.dart';
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

  var _files = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var userDetails = context.read<UserBloc>().user;

    BlocProvider.of<FileBloc>(context)
        .add(LoadFiles(context.read<UserBloc>().user.email!));
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
          body: BlocConsumer<FileBloc, FileState>(
            listener: (context, state) {
              if (state is FileLoaded) {
                _files = state.files;
              }
            },
            builder: (context, state) {
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
                              CategoryTile(
                                  category: "Folders",
                                  icon: Icons.folder_rounded,
                                  color: green,
                                  onTap: (() => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CategoryContentPage(
                                                title: "Folders",
                                                userEmail: userDetails.email,
                                                test: (PathObject o) =>
                                                    o.isFolder!,
                                              ))))),
                              CategoryTile(
                                  category: "Files",
                                  icon: Icons.insert_drive_file_rounded,
                                  color: blueOcean,
                                  onTap: (() => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CategoryContentPage(
                                                title: "Files",
                                                userEmail: userDetails.email,
                                                test: (PathObject o) =>
                                                    !o.isFolder!,
                                              ))))),
                              CategoryTile(
                                category: "Shared",
                                icon: Icons.folder_shared_rounded,
                                color: purple,
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const SharedPage()));
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
