import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:space_client_app/views/page/home/menu.dart';
import 'package:space_client_app/views/page/pages.dart';
import 'package:space_client_app/views/theme/colors.dart';

class PageDriver extends StatefulWidget {
  const PageDriver({Key? key}) : super(key: key);

  @override
  State<PageDriver> createState() => _PageDriverState();
}

class _PageDriverState extends State<PageDriver> {
  List<IconData> icons = [
    Icons.home,
    Icons.star,
    Icons.workspaces,
    Icons.person
  ];

  int currentPage = 0;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentPage);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(),
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: AppPages.pages,
        onPageChanged: (v) {
          setState(() => currentPage = v);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              elevation: 3,
              constraints: BoxConstraints(
                  maxHeight: size.height * .25, minWidth: size.width),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24))),
              builder: (context) {
                return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Add to SpaceFile"),
                        const SizedBox(
                          height: 24,
                        ),
                        Flexible(
                            child: ListView(
                          children: const [
                            ListTile(
                              leading: Icon(Icons.note_add_outlined),
                              title: Text("Upload a File"),
                            ),
                            ListTile(
                              leading: Icon(Icons.folder_open_outlined),
                              title: Text("Create New Folder"),
                            ),
                            ListTile(
                              leading: Icon(Icons.upload_file),
                              title: Text("Upload from Computer"),
                            )
                          ],
                        ))
                      ],
                    ));
              });
        },
        tooltip: 'Open Add',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
          backgroundColor: blue,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          inactiveColor: grey,
          activeColor: green,
          icons: icons,
          activeIndex: currentPage,
          onTap: (v) {
            setState(() {
              controller.animateToPage(v,
                  duration: const Duration(microseconds: 800),
                  curve: Curves.easeIn);
            });
          }),
    );
  }
}
