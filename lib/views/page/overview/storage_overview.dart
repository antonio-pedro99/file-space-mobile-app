import 'package:flutter/material.dart';

class StorageOverviewPage extends StatefulWidget {
  const StorageOverviewPage({Key? key}) : super(key: key);
  @override
  State<StorageOverviewPage> createState() => _StorageOverviewPageState();
}

class _StorageOverviewPageState extends State<StorageOverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                centerTitle: true,
                forceElevated: innerBoxIsScrolled,
                title: const Text("Overview"),
                floating: true,
              )
            ];
          },
          body: SafeArea(
              maintainBottomViewPadding: true,
              top: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 350,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: const EdgeInsets.all(8),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(24)),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: "Search for anything",
                            prefixIcon: const Icon(Icons.search_sharp),
                          ),
                        )),
                  ],
                ),
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
