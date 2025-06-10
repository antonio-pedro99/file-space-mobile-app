import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:space_client_app/blocs/file/file_bloc.dart';
import 'package:space_client_app/blocs/user/user_bloc.dart';
import 'package:space_client_app/data/models/object.dart';
import 'package:space_client_app/data/models/user.dart';
import 'package:space_client_app/extensions.dart';
import 'package:space_client_app/views/page/folder%20content/folder.dart';
import 'package:space_client_app/views/page/functions.dart';
import 'package:space_client_app/views/page/home/enums.dart';
import 'package:space_client_app/views/theme/colors.dart';

const magicColors = [deepPurple, green, blueOcean, purple, pink];

mixin MenuActions {}

extension ActionExtensions on MenuActions {
  void openMenu(type, context, name, parent, userEmail) {
    if (type == FileType.folder) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FolderContentPage(
                title: name,
                parent: parent,
                userEmail: userEmail,
              )));
    }
  }
}

class FileTile extends StatelessWidget with MenuActions {
  const FileTile({super.key, required this.object});

  final PathObject object;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var color = Colors.pink;
    //var color = magicColors[math.Random().nextInt(magicColors.length)];
    var userDetails = context.read<UserBloc>().uDetails;
    return ListTile(
        onTap: () => openMenu(object.getType(), context, object.fileName,
            getParentPath(object.filePath!), userDetails.user!.email),
        leading: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(8)),
          child: Icon(object.getIcon()),
        ),
        title: Text(
          object.fileName!,
          style: textTheme.titleMedium!
              .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        subtitle: object.getType() != FileType.folder
            ? Text("Size :${object.isFolder}")
            : Text("Last Modified :${object.modified}"),
        trailing: IconButton(
          onPressed: () => showOptions(context, object.getIcon(), object, color,
              object.getType(), userDetails),
          // onPressed: () => {},
          icon: const Icon(Icons.more_horiz_outlined),
        ));
  }
}

void showOptions(BuildContext context, IconData iconData, PathObject file,
    color, FileType type, UserDetails<User> user) {
  bool isUpdating = false;
  showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      elevation: 3,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      builder: (context) {
        return BlocConsumer<FileBloc, FileState>(
          listener: (context, state) {
            if (state is FileIsUpdating) {
              isUpdating = true;
            } else if (state is FileUpdated) {
              switch (state.attributeUpdate) {
                case AttributeUpdate.star:
                  isUpdating = false;

                  BlocProvider.of<FileBloc>(context)
                      .add(LoadFiles(user.user!.email!));
                  break;

                case AttributeUpdate.link:
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: const Duration(milliseconds: 1000),
                      dismissDirection: DismissDirection.endToStart,
                      content: Text(
                        state.message!,
                      )));
                  break;
                case AttributeUpdate.share:
                  break;
                case AttributeUpdate.none:
                  print(state.message);
                  Share.shareXFiles([XFile(state.message!)],
                      subject: file.fileName);
                  break;
                default:
              }
              Navigator.of(context).pop();
            } else if (state is FileDownUploadError) {}
          },
          builder: (context, state) {
            return DraggableScrollableSheet(
                initialChildSize: .5,
                minChildSize: .1,
                maxChildSize: .8,
                expand: false,
                builder: (context, scrollController) {
                  return ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(12),
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                iconData,
                                color: color,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                file.fileName!,
                                softWrap: true,
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Something",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Visibility(
                          visible: isUpdating,
                          child: const LinearProgressIndicator(
                            minHeight: 1,
                          )),
                      const SizedBox(
                        height: 24,
                      ),
                      const ListTile(
                        leading: Icon(Icons.share_outlined),
                        title: Text("Share"),
                      ),
                      ListTile(
                        leading: const Icon(Icons.link_outlined),
                        title: const Text("Copy link"),
                        onTap: () => BlocProvider.of<FileBloc>(context)
                            .add(UpdateFile(file, AttributeUpdate.link)),
                      ),
                      type != FileType.folder
                          ? const ListTile(
                              leading: Icon(Icons.workspaces_outlined),
                              title: Text("Add to workspace"),
                            )
                          : const ListTile(
                              leading: Icon(Icons.people_outline),
                              title: Text("Manage access"),
                            ),
                      type == FileType.folder
                          ? const SizedBox()
                          : ListTile(
                              onTap: () {
                                BlocProvider.of<FileBloc>(context).add(
                                    UpdateFile(file, AttributeUpdate.none));
                              },
                              leading: const Icon(Icons.turn_slight_right),
                              title: const Text("Send a copy"),
                            ),
                      const Divider(),
                      ListTile(
                        onTap: () {
                          print(file.filePath);
                        },
                        leading: Icon(Icons.drive_file_rename_outline_outlined),
                        title: Text("Rename"),
                      ),
                      ListTile(
                        onTap: () => BlocProvider.of<FileBloc>(context)
                            .add(UpdateFile(file, AttributeUpdate.star)),
                        leading: Icon(Icons.star_outline_outlined),
                        title: Text("Add to starred"),
                      ),
                      type != FileType.folder
                          ? const ListTile(
                              leading: Icon(Icons.copy),
                              title: Text("Make a copy"),
                            )
                          : const ListTile(
                              leading: Icon(Icons.color_lens),
                              title: Text("Change Color"),
                            ),
                      type != FileType.folder
                          ? ListTile(
                              leading: const Icon(Icons.file_download_outlined),
                              title: const Text("Download"),
                              onTap: (() {
                                BlocProvider.of<FileBloc>(context)
                                    .add(FileDownload(file: file));
                                Navigator.of(context).pop();
                              }),
                            )
                          : Container(),
                      const Divider(),
                      const ListTile(
                        leading: Icon(Icons.drive_file_move_outlined),
                        title: Text("Move"),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.delete, color: Colors.red),
                        title: Text(
                          "Delete",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.red),
                        ),
                        onTap: () => deleteFile(context, file),
                      )
                    ],
                  );
                });
          },
        );
      });
}
