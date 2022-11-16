import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:space_client_app/views/page/home/enums.dart';
import 'package:space_client_app/views/theme/colors.dart';

const magicColors = [deepPurple, green, blueOcean, purple];

class FileTile extends StatelessWidget {
  const FileTile(
      {Key? key, required this.name, required this.size, required this.type})
      : super(key: key);

  final String name;
  final String size;
  final FileType type;
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    IconData _buildIcon(FileType type) {
      switch (type) {
        case FileType.music:
          return Icons.music_note;
        case FileType.image:
          return Icons.image;
        case FileType.video:
          return Icons.play_arrow;
        case FileType.document:
          return Icons.note;
        case FileType.other:
          return Icons.devices_other;
        case FileType.folder:
          return Icons.folder;
      }
    }

    return ListTile(
      leading: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: magicColors[math.Random().nextInt(magicColors.length)],
            borderRadius: BorderRadius.circular(8)),
        child: Icon(_buildIcon(type)),
      ),
      title: Text(
        name,
        style: textTheme.titleMedium!
            .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(size),
      trailing: const Icon(Icons.more_horiz_outlined),
    );
  }
}
