import 'package:flutter/material.dart';
import 'package:space_client_app/views/page/auth/login.dart';
import 'package:space_client_app/views/page/auth/signup.dart';
import 'package:space_client_app/views/theme/colors.dart';
import 'package:space_client_app/views/widgets/button_text.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);
  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
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
          body: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
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
                          onTap: () => Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                              (route) => false),
                        ),
                        CustomButton(
                          text: "Signup",
                          isOutlined: true,
                          onTap: () => Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const SignupPage()),
                              (route) => false),
                        )
                      ],
                    )
                  ],
                ),
              ))),
    );
  }
}
