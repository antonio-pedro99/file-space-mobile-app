import 'package:flutter/material.dart';
import 'package:space_client_app/views/theme/colors.dart';

class StatTile extends StatelessWidget {
  const StatTile(
      {Key? key,
      required this.fileTypeName,
      this.color = purple,
      required this.icon,
      required this.totalFiles})
      : super(key: key);

  final String fileTypeName;
  final int totalFiles;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration:
            BoxDecoration(color: blue, borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          minVerticalPadding: 0,
          onTap: () {},
          leading: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon),
          ),
          title: Text(
            fileTypeName,
            style: textTheme.titleMedium!
                .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          subtitle: Text("$totalFiles files"),
          trailing: const Icon(Icons.more_vert),
        ));
  }
}
