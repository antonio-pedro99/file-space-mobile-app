// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/blocs/auth/auth_bloc.dart';
import 'package:space_client_app/data/models/auth/user_register.dart';
import 'package:space_client_app/data/repository/auth.dart';
import 'package:space_client_app/views/page/auth/confirm.dart';
import 'package:space_client_app/views/page/auth/login.dart';
import 'package:space_client_app/views/theme/colors.dart';
import 'package:space_client_app/views/widgets/button_text.dart';
import 'package:space_client_app/views/widgets/input_text.dart';
import 'package:space_client_app/app.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var keyForm = GlobalKey<FormState>();

  final textNameController = TextEditingController();
  final textEmailController = TextEditingController();
  final textPhoneController = TextEditingController();
  final textPasswordController = TextEditingController();

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
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      state.message,
                      style: const TextStyle(color: Colors.white),
                    )));
              } else if (state is AuthLoading) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                  "Logging in",
                  style: TextStyle(),
                )));
              } else if (state is AuthLoaded) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => ConfirmRegistrationPage(
                              email: state.email,
                            )),
                    (route) => false);
              }
            },
            builder: (context, state) {
              return SafeArea(
                maintainBottomViewPadding: true,
                top: false,
                child: Form(
                    key: keyForm,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(20)
                          .copyWith(top: size.height * .1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/cloud.png"),
                          const SizedBox(height: 34),
                          CustomTextInput(
                            hint: "Complete Name",
                            border: 16,
                            leading: Icons.person,
                            controller: textNameController,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextInput(
                            hint: "Enter Email",
                            border: 16,
                            controller: textEmailController,
                            leading: Icons.email,
                            /*  validator: (email) {
                                    if (!email!.isEmail()) {
                                      return "Invalid email. Valid email should look like dev@gmail.com";
                                    }
                                    return "";
                                  }, */
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextInput(
                            hint: "Password",
                            border: 16,
                            leading: Icons.lock,
                            controller: textPasswordController,
                            isPassword: true,
                          ),
                          const SizedBox(
                            height: 34,
                          ),
                          CustomButton(
                            text: "Register",
                            textColor: white,
                            color: purple,
                            widget: size.width * .5,
                            onTap: () async {
                              if (keyForm.currentState!.validate()) {
                                var userRegister = UserSignUpModel(
                                    password: textPasswordController.text,
                                    phoneNumber: textPhoneController.text,
                                    email: textEmailController.text,
                                    name: textNameController.text);

                                BlocProvider.of<AuthBloc>(context).add(Signup(
                                    email: userRegister.email,
                                    name: userRegister.name,
                                    password: userRegister.password));
                                /* var result = await AuthenticationUser.signUp(
                                    userRegister); */
                                /* if (!result["status"]) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            result["message"],
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )));
                                } else {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ConfirmRegistrationPage(
                                                email: userRegister.email,
                                              )),
                                      (route) => false);
                                } */
                              }
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextButton(
                              onPressed: () => Navigator.of(context)
                                  .pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                      (route) => false),
                              child:
                                  const Text("already have an account? Login!"))
                        ],
                      ),
                    )),
              );
            },
          )),
    );
  }
}
