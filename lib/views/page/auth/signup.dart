import 'package:flutter/material.dart';
import 'package:space_client_app/views/page/auth/login.dart';
import 'package:space_client_app/views/theme/colors.dart';
import 'package:space_client_app/views/widgets/button_text.dart';
import 'package:space_client_app/views/widgets/input_text.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
            maintainBottomViewPadding: true,
            top: false,
            child: Form(
                key: keyForm,
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.all(20).copyWith(top: size.height * .1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/cloud.png"),
                      const SizedBox(height: 34),
                      const CustomTextInput(
                        hint: "Complete Name",
                        border: 16,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const CustomTextInput(
                        hint: "Enter Email",
                        border: 16,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const CustomTextInput(
                        hint: "New Password",
                        border: 16,
                      ),
                      const SizedBox(height: 16),
                      const CustomTextInput(
                        hint: "Confirm Password",
                        border: 16,
                      ),
                      const SizedBox(
                        height: 34,
                      ),
                      CustomButton(
                        text: "Register",
                        textColor: white,
                        color: purple,
                        widget: size.width * .5,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextButton(
                          onPressed: () => Navigator.of(context)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false),
                          child: const Text("already have an account? Login!"))
                    ],
                  ),
                )),
          )),
    );
  }
}
