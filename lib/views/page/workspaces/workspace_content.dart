import 'package:flutter/material.dart';
import 'package:space_client_app/views/page/home/menu.dart';

class WorkSpaceContentPage extends StatefulWidget {
  const WorkSpaceContentPage({Key? key}) : super(key: key);
  @override
  State<WorkSpaceContentPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WorkSpaceContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                title: const Text("My Workspaces"),
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
                    Flexible(
                        child: ListView(
                      children: const [],
                    ))
                  ],
                ),
              ))),
    );
  }
}
