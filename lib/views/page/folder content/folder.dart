import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/blocs/file/file_bloc.dart';
import 'package:space_client_app/data/models/object.dart';
import 'package:space_client_app/views/page/functions.dart';
import 'package:space_client_app/views/page/home/widgets/file_tile.dart';
import 'package:space_client_app/views/theme/colors.dart';
import 'package:space_client_app/views/widgets/sort_navigator.dart';

class FolderContentPage extends StatefulWidget {
  const FolderContentPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<FolderContentPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FolderContentPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FileBloc>(context).add(LoadFiles());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    List<PathObject> _files = [];
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
                          print("files = ${state.files}");
                          _files = state.files;
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
    );
  }
}
