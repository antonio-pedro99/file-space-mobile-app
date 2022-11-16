import 'package:flutter/material.dart';
import 'package:space_client_app/views/page/pages.dart';

class PageDriver extends StatefulWidget {
  const PageDriver({Key? key}) : super(key: key);

  @override
  State<PageDriver> createState() => _PageDriverState();
}

class _PageDriverState extends State<PageDriver> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: AppPages.controller,
        children: AppPages.pages,
        onPageChanged: (v) {
          setState(() => _currentPage = v);
        },
      ),
    );
  }
}
