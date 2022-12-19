import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/blocs/user/user_bloc.dart';
import 'package:space_client_app/data/models/object.dart';
import 'package:space_client_app/views/page/category%20content/content.dart';
import 'package:space_client_app/views/page/desktop/device_tile.dart';

class DesktopFilesPage extends StatefulWidget {
  const DesktopFilesPage({Key? key, required this.title, this.userEmail})
      : super(key: key);

  final String title;
  final String? userEmail;
  @override
  State<DesktopFilesPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DesktopFilesPage> {
  var folderNameTextController = TextEditingController();

  List<PathObject> _files = [];
  @override
  void initState() {
    super.initState();
    folderNameTextController.text = "New Folder";
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var userDetails = context.read<UserBloc>().user;

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
                child: userDetails.computers!.isNotEmpty
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 180,
                          childAspectRatio: 3 / 4,
                        ),
                        itemCount: userDetails.computers!.length,
                        itemBuilder: (context, index) {
                          return DeviceTile(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CategoryContentPage(
                                            title:
                                                "Computer ${userDetails.computers![index].deviceName}",
                                            userEmail: userDetails.email,
                                            test: (PathObject o) => o.filePath!
                                                .startsWith("/My Space"),
                                          ))),
                              device: userDetails.computers![index]);
                        })
                    : Center(
                        child: Text(
                          "You do not have any sync folder. Install our desktop app on your laptop",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5,
                        ),
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
                return FutureBuilder<String>(
                    future: context.read<UserBloc>().userAttr.promptDesktop(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error as String));
                        }
                        return Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text("Add Desktop"),
                                const SizedBox(
                                  height: 24,
                                ),
                                Center(child: Text(snapshot.data as String))
                              ],
                            ));
                      }
                      return Container();
                    });
              });
        },
        tooltip: 'Open Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
