import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

abstract class FileTileType {}

extension BuildIcon on FileTileType {
  IconData getIcon(type) {
    switch (type) {
      case FileType.music:
        return Icons.music_note;
      case FileType.image:
        return Icons.image;
      case FileType.video:
        return Icons.play_arrow;
      case FileType.document:
        return Icons.insert_drive_file;
      case FileType.other:
        return Icons.insert_drive_file;
      case FileType.folder:
        return Icons.folder;
    }
    return Icons.abc;
  }

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

class FileTile extends StatelessWidget with FileTileType {
  const FileTile({Key? key, required this.object}) : super(key: key);

  final PathObject object;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var color = Colors.pink;
    //var color = magicColors[math.Random().nextInt(magicColors.length)];
    var user = context.read<UserBloc>().user;
    return ListTile(
        onTap: () => openMenu(object.getType(), context, object.fileName,
            getParentPath(object.filePath!), user.email),
        leading: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(8)),
          child: Icon(getIcon(object.getType())),
        ),
        title: Text(
          object.fileName!,
          style: textTheme.titleMedium!
              .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        subtitle: object.getType() != FileType.folder
            ? Text(
                "${object.fileSize!.toDouble().getSizeFormat().keys.first.toStringAsFixed(2)} ${object.fileSize!.toDouble().getSizeFormat().values.first}")
            : Text("Last Modified :${object.modified}"),
        trailing: IconButton(
          onPressed: () => showOptions(context, getIcon(object.getType()),
              object, color, object.getType(), user),
          icon: const Icon(Icons.more_horiz_outlined),
        ));
  }
}

void showOptions(BuildContext context, IconData iconData, PathObject file,
    color, FileType type, UserAuthDetails user) {
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
                      .add(LoadFiles(user.email!));
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                iconData,
                                color: color,
                              ),
                              const SizedBox(width: 10),
                              Text(file.fileName!)
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            !file.isFolder!
                                ? " ${file.fileSize!.toDouble().getSizeFormat().keys.first.toStringAsFixed(2)} ${file.fileSize!.toDouble().getSizeFormat().values.first}, ${file.modified!}"
                                : file.modified!,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
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
                      const Divider(),
                      const ListTile(
                        leading: Icon(Icons.drive_file_rename_outline_outlined),
                        title: Text("Rename"),
                      ),
                      ListTile(
                        onTap: () => BlocProvider.of<FileBloc>(context)
                            .add(UpdateFile(file, AttributeUpdate.star)),
                        leading: Icon(file.isStarred!
                            ? Icons.star_sharp
                            : Icons.star_outline_outlined),
                        title: Text(file.isStarred!
                            ? "Remove from starred"
                            : "Add to starred"),
                        trailing: Visibility(
                            visible: isUpdating,
                            child: const SizedBox(
                              height: 10,
                              width: 10,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            )),
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
