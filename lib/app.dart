import 'package:space_client_app/views/page/home/home.dart';
import 'package:space_client_app/views/page/page_driver.dart';
import 'package:space_client_app/views/theme/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceFile',
      debugShowCheckedModeBanner: false,
      theme: MyAppTheme.dark,
      home: const PageDriver(),
    );
  }
}
