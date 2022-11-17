import 'package:flutter/material.dart';
import 'package:space_client_app/views/page/home/menu.dart';
import 'package:space_client_app/views/page/workspaces/widgets/workspace_tile.dart';
import 'package:space_client_app/views/widgets/input_text.dart';

class CategoryContentPage extends StatefulWidget {
  const CategoryContentPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<CategoryContentPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CategoryContentPage> {
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
                title: Text(widget.title),
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
                    const CustomTextInput(
                      hint: "Search for anything",
                      leading: Icons.search,
                    ),
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
