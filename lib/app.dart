import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/blocs/auth/auth_bloc.dart';
import 'package:space_client_app/blocs/user/user_bloc.dart';

import 'package:space_client_app/data/repository/auth.dart';
import 'package:space_client_app/views/page/auth/onboarding.dart';
import 'package:space_client_app/views/theme/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          home: const OnBoardingPage(),
        ));
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
