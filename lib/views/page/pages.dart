import 'package:flutter/cupertino.dart';
import 'package:space_client_app/views/page/home/home.dart';
import 'package:space_client_app/views/page/profile/profile.dart';

class AppPages {
  static List<Widget> pages = const [
    MyHomePage(),
    ProfilePage(),
  ];
  static PageController controller = PageController();
}
