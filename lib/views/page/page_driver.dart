import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: AppPages.controller,
        children: AppPages.pages,
        onPageChanged: (v) {
          setState(() => AppPages.currentPage = v);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
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
          activeIndex: AppPages.currentPage,
          onTap: (v) {
            setState(() {
              AppPages.controller.animateToPage(v,
                  duration: const Duration(microseconds: 800),
                  curve: Curves.easeIn);
            });
          }),
    );
  }
}
