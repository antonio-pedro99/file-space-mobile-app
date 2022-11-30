import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_client_app/blocs/auth/auth_bloc.dart';
import 'package:space_client_app/blocs/user/user_bloc.dart';

import 'package:space_client_app/data/repository/auth.dart';
import 'package:space_client_app/views/page/auth/onboarding.dart';
import 'package:space_client_app/views/page/page_driver.dart';
import 'package:space_client_app/views/theme/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<SharedPreferences> authPrefs = SharedPreferences.getInstance();

  Future<bool?> isLogged() async {
    final _prefs = await authPrefs;

    return _prefs.getBool("status");
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: (_) => AuthBloc(authRepository: AuthenticationUser())),
          BlocProvider<UserBloc>(create: (_) => UserBloc())
        ],
        child: MaterialApp(
            title: 'SpaceFile',
            debugShowCheckedModeBanner: false,
            theme: MyAppTheme.dark,
            home: FutureBuilder(
                future: isLogged(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || (snapshot.data as bool) == false) {
                    return const OnBoardingPage();
                  }

                  return const PageDriver();
                })));
  }
}

extension PasswordChecker on String {
  bool isPasswordStrong() {
    var strongPattern = RegExp(
        r'(?=^.{8,}$)(?=.*\d)(?=.*[!@#$%^&*]+)(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$');
    var awsPattern = RegExp(r'^[\S]+.*[\S]+$');
    return strongPattern.hasMatch(this) && awsPattern.hasMatch(this);
  }
}

extension EmailChecker on String {
  bool isEmail() {
    var emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailPattern.hasMatch(this);
  }
}
