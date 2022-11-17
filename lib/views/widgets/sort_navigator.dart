import 'package:flutter/material.dart';

class SortNavigator extends StatefulWidget {
  const SortNavigator({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<SortNavigator> createState() => _SortNavigatorState();
}

class _SortNavigatorState extends State<SortNavigator> {
  final _options = ["Modified", "Name", "Size"];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(widget.title),
            const SizedBox(
              height: 24,
            ),
            Flexible(
                child: ListView.builder(
                    itemCount: _options.length,
                    itemBuilder: (context, index) {
                      bool isActive = current == index;
                      return ListTile(
                          leading: isActive
                              ? const Icon(Icons.check)
                              : const SizedBox(),
                          title: Text(_options[index]),
                          onTap: () => setState(() => current = index));
                    }))
          ],
        ));
  }
}
