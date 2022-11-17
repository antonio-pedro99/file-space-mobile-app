import 'package:space_client_app/views/page/auth/login.dart';
import 'package:space_client_app/views/page/auth/onboarding.dart';
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
      home: const OnBoardingPage(),
    );
  }
}
