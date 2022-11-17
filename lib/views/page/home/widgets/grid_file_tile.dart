import 'package:flutter/material.dart';
import 'package:space_client_app/views/page/home/enums.dart';
import 'package:space_client_app/views/page/home/widgets/file_tile.dart';
import 'dart:math' as math;

class GridFileTile extends StatelessWidget with FileTileType {
  const GridFileTile(
      {Key? key, required this.type, this.size, required this.name})
      : super(key: key);

  final FileType type;
  final String name;
  final String? size;
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var color = magicColors[math.Random().nextInt(magicColors.length)];
    return Container(
      width: 100,
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            getIcon(type),
            size: 100,
            color: color,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              type != FileType.folder
                  ? IconButton(
                      onPressed: () {},
                      icon: Icon(
                        getIcon(type),
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
                  name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium!
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              )
            ],
          )
        ],
      ),
    );
  }
}
