import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:space_client_app/data/models/cloud_storage.dart';

import '../../../theme/colors.dart';

class CloudStorageConnectionTile extends StatelessWidget {
  const CloudStorageConnectionTile({super.key, required this.cloudStorage});

  final CloudStorage cloudStorage;
  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(left: 8),
      decoration: const BoxDecoration(
        color: blue,
        shape: BoxShape.circle,
      ),
      child: Tooltip(
        message: cloudStorage.cloudStorageName!,
        child: SvgPicture.asset(
          cloudStorage.icon!,
          width: 40,
          height: 40,
        ),
      ),
    );
  }
}
