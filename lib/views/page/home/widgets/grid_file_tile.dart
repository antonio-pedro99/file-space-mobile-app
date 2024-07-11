import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/blocs/user/user_bloc.dart';
import 'package:space_client_app/data/models/object.dart';
import 'package:space_client_app/views/page/folder%20content/folder.dart';
import 'package:space_client_app/views/page/functions.dart';
import 'package:space_client_app/views/page/home/enums.dart';
import 'package:space_client_app/views/page/home/widgets/file_tile.dart';
import 'dart:math' as math;

class GridFileTile extends StatelessWidget with FileTileType {
  const GridFileTile({Key? key, required this.object}) : super(key: key);

  final PathObject object;

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

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var color = magicColors[math.Random().nextInt(magicColors.length)];
    var user = context.read<UserBloc>().uDetails.user;

    return InkWell(
      onTap: () => openMenu(object.getType(), context, object.fileName,
          getParentPath(object.filePath!), user!.email),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              getIcon(object.getType()),
              size: 100,
              color: color,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                object.getType() != FileType.folder
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(
                          getIcon(object.getType()),
                          color: color,
                          size: 18,
                        ),
                      )
                    : const SizedBox(
                        width: 18,
                        height: 18,
                      ),
                SizedBox(
                  width: 50,
                  child: Text(
                    object.fileName!,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium!
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                IconButton(
                  // onPressed: () => showOptions(
                  //     context,
                  //     getIcon(object.getType()),
                  //     object,
                  //     color,
                  //     object.getType()),
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
