import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:space_client_app/amplifyconfiguration.dart';

import 'package:space_client_app/views/page/auth/signup.dart';
import 'package:space_client_app/views/page/page_driver.dart';
import 'package:space_client_app/views/theme/colors.dart';
import 'package:space_client_app/views/widgets/button_text.dart';
import 'package:space_client_app/views/widgets/input_text.dart';
import 'package:space_client_app/app.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var keyForm = GlobalKey<FormState>();
 

  @override
  void initState() {
    super.initState();
   
  }

  

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
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                          .copyWith(top: size.height * .1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/cloud.png"),
                      const SizedBox(height: 34),
                      const CustomTextInput(
                        hint: "Enter Email",
                        border: 16,
                        leading: Icons.email,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextInput(
                        leading: Icons.lock,
                        hint: "Enter Password",
                        border: 16,
                        isPassword: true,
                        validator: (password) {
                          if (!password!.isPasswordStrong()) {
                            return "Week Password";
                          }
                          return "";
                        },
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                          text: "Login",
                          textColor: white,
                          color: purple,
                          widget: size.width * .5,
                          onTap: () {
                            if (keyForm.currentState!.validate()) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const PageDriver()),
                                  (route) => false);
                            }
                          }),
                      const SizedBox(
                        height: 24,
                      ),
                      TextButton(
                          onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const SignupPage()),
                              ),
                          child: const Text("Do not have an account? Signup!"))
                    ],
                  ),
                )),
          )),
    );
  }
}
