import 'package:flutter/material.dart';
import 'package:space_client_app/views/page/home/home.dart';
import 'package:space_client_app/views/page/profile/profile.dart';
import 'package:space_client_app/views/page/starred/starred.dart';
import 'package:space_client_app/views/page/workspaces/workspaces.dart';

class AppPages {
  static List<Widget> pages = const [
    MyHomePage(),
    StarredPage(),
    WorkSpacePage(),
    ProfilePage(),
  ];
}
