import 'package:flutter/material.dart';
import 'package:space_client_app/views/theme/colors.dart';

class FileTile extends StatelessWidget {
  const FileTile({Key? key, required this.name, required this.size})
      : super(key: key);

  final String name;
  final String size;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return ListTile(
      leading: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: deepPurple, borderRadius: BorderRadius.circular(8)),
        child: Icon(Icons.image),
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
