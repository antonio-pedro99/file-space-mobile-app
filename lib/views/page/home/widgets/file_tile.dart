import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:space_client_app/data/models/object.dart';
import 'package:space_client_app/extensions.dart';
import 'package:space_client_app/views/page/folder%20content/folder.dart';
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

  void openMenu(type, context, name) {
    if (type == FileType.folder) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FolderContentPage(title: name)));
    }
  }
}

class FileTile extends StatelessWidget with FileTileType {
  const FileTile({Key? key, required this.object}) : super(key: key);

  final PathObject object;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var color = magicColors[math.Random().nextInt(magicColors.length)];
    return ListTile(
        onTap: () => openMenu(object.getType(), context, object.fileName),
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
                "${object.fileSize!.toDouble().getSizeFormat().toStringAsFixed(2)} MB")
            : Text("Last Modified :${object.modified}"),
        trailing: IconButton(
          onPressed: () => showOptions(context, getIcon(object.getType()),
              object.fileName!, color, object.getType()),
          icon: const Icon(Icons.more_horiz_outlined),
        ));
  }

  void showOptions(BuildContext context, IconData iconData, String fileName,
      color, FileType type) {
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          iconData,
                          color: color,
                        ),
                        const SizedBox(width: 10),
                        Text(fileName)
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const ListTile(
                      leading: Icon(Icons.share_outlined),
                      title: Text("Share"),
                    ),
                    const ListTile(
                      leading: Icon(Icons.link_outlined),
                      title: Text("Copy link"),
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
                    const ListTile(
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
                        ? const ListTile(
                            leading: Icon(Icons.file_download_outlined),
                            title: Text("Download"),
                          )
                        : Container(),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text("Details"),
                    ),
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
                    )
                  ],
                );
              });
        });
  }
}
