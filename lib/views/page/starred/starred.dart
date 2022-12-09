import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/blocs/file/file_bloc.dart';
import 'package:space_client_app/data/models/object.dart';
import 'package:space_client_app/views/page/home/widgets/file_tile.dart';
import 'package:space_client_app/views/widgets/input_text.dart';

class StarredPage extends StatefulWidget {
  const StarredPage({Key? key, this.userEmail}) : super(key: key);
    final String? userEmail;
  @override
  State<StarredPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<StarredPage> {
    List<PathObject> _files = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                title: const Text("My Favorites"),
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
                   Flexible(
                        child: BlocConsumer<FileBloc, FileState>(
                      listener: (context, state) {
                        if (state is FileLoaded) {
                          _files = state.files
                              .where((element) => element.isStarred!)
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
                    )
                ),
          ])),
    )));
  }
}
