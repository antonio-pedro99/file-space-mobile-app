import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_auth_cognito/method_channel_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/blocs/user/user_bloc.dart';
import 'package:space_client_app/views/page/auth/login.dart';
import 'package:space_client_app/views/page/auth/signup.dart';
import 'package:space_client_app/views/page/page_driver.dart';
import 'package:space_client_app/views/theme/colors.dart';
import 'package:space_client_app/views/widgets/button_text.dart';

import '../../../amplifyconfiguration.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);
  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final amplify = Amplify;
  late StreamSubscription subscription;
  late bool isLoggedIn;

  String session = '';
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    final auth = AmplifyAuthCognito();
    final storage = AmplifyStorageS3();

    try {
      await amplify.addPlugins([auth, storage]);
      await amplify.configure(amplifyconfig);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _isSignedIn() async {
    final _s = await Amplify.Auth.fetchAuthSession();

    return _s.isSignedIn;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: deepPurple,
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                centerTitle: true,
                toolbarHeight: 0,
                forceElevated: innerBoxIsScrolled,
                floating: true,
              )
            ];
          },
          body: Builder(builder: (context) {
            return isLoggedIn
                ? Container()
                : SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8)
                          .copyWith(top: 55),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/cover.png"),
                          const SizedBox(height: 34),
                          Text(
                            "Save and share your files on the cloud.",
                            style: textTheme.displaySmall,
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                text: "Login",
                                widget: MediaQuery.of(context).size.width * .6,
                                onTap: () => Navigator.of(context)
                                    .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()),
                                        (route) => false),
                              ),
                              CustomButton(
                                text: "Signup",
                                isOutlined: true,
                                onTap: () => Navigator.of(context)
                                    .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignupPage()),
                                        (route) => false),
                              )
                            ],
                          )
                        ],
                      ),
                    ));
          })),
    );
  }
}
