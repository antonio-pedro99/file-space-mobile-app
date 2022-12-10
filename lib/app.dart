import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_client_app/blocs/auth/auth_bloc.dart';
import 'package:space_client_app/blocs/file/file_bloc.dart';
import 'package:space_client_app/blocs/user/user_bloc.dart';
import 'package:space_client_app/data/repository/auth.dart';
import 'package:space_client_app/views/page/auth/onboarding.dart';
import 'package:space_client_app/views/page/page_driver.dart';
import 'package:space_client_app/views/theme/theme.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<SharedPreferences> authPrefs = SharedPreferences.getInstance();

  Future<bool?> isLogged() async {
    final prefs = await authPrefs;

    return prefs.getBool("status");
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: (_) => AuthBloc(authRepository: AuthenticationUser())),
          BlocProvider<UserBloc>(create: (_) => UserBloc()),
          BlocProvider<FileBloc>(create: (_) => FileBloc())
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
