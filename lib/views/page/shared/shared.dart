import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:space_client_app/app.dart';
import 'package:space_client_app/views/widgets/input_text.dart';

class SharedPage extends StatefulWidget {
  const SharedPage({Key? key}) : super(key: key);
  @override
  State<SharedPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SharedPage> {
  late final Future<ListResult> files;

  @override
  void initState() {
    super.initState();
  }

  Future<List<StorageItem>> _loadFiles() async {
    try {
      final result = await Amplify.Storage.list(
          options: ListOptions(accessLevel: StorageAccessLevel.private));

      return result.items;
    } on StorageException catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                title: const Text("Shared with you"),
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
                        child: FutureBuilder<List<StorageItem>>(
                            future: _loadFiles(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text(snapshot.error.toString()));
                              }
                              var files = snapshot.data;
                              return ListView.builder(
                                itemCount: files!.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  bool isFolder = files[index].key.isFolder();
                                  return ListTile(
                                      title: isFolder
                                          ? Text(
                                              files[index].key.getFolderName())
                                          : Text(files[index].key),
                                      subtitle: isFolder
                                          ? Text(files[index]
                                              .size!
                                              .toDouble()
                                              .getSizeFormat()
                                              .toStringAsFixed(1))
                                          : Text(
                                              "${(files[index].size! / 1024).toStringAsFixed(2)} KB"));
                                },
                              );
                            }))
                  ],
                ),
              ))),
    );
  }
}
