import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/blocs/auth/auth_bloc.dart';
import 'package:space_client_app/data/models/auth/user_login.dart';
import 'package:space_client_app/views/page/auth/signup.dart';
import 'package:space_client_app/views/page/page_driver.dart';
import 'package:space_client_app/views/theme/colors.dart';
import 'package:space_client_app/views/widgets/button_text.dart';
import 'package:space_client_app/views/widgets/input_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.email}) : super(key: key);
  final String? email;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var keyForm = GlobalKey<FormState>();

  final textEmailController = TextEditingController();
  final textPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEmailController.text = widget.email ?? "";
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
                    MaterialPageRoute(builder: (context) => const PageDriver()),
                    (route) => false);
              }
            },
            builder: (context, state) {
              bool passwordIsHidden = true;
              return SafeArea(
                maintainBottomViewPadding: true,
                top: false,
                child: Form(
                    key: keyForm,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8)
                          .copyWith(top: size.height * .1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/cloud.png"),
                          const SizedBox(height: 34),
                          CustomTextInput(
                            hint: "Enter Email",
                            border: 16,
                            type: TextInputType.emailAddress,
                            leading: Icons.email,
                            controller: textEmailController,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextInput(
                              leading: Icons.lock,
                              hint: "Enter Password",
                              border: 16,
                              type: TextInputType.visiblePassword,
                              isPassword: passwordIsHidden,
                              controller: textPasswordController,
                              trailing: IconButton(
                                icon: const Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    passwordIsHidden = !passwordIsHidden;
                                  });
                                },
                              )),
                          const SizedBox(height: 24),
                          CustomButton(
                              text: "Login",
                              textColor: white,
                              color: purple,
                              widget: size.width * .5,
                              onTap: () async {
                                if (keyForm.currentState!.validate()) {
                                  var userDetails = UserLoginModel(
                                      password: textPasswordController.text,
                                      email: textEmailController.text);

                                  BlocProvider.of<AuthBloc>(context).add(Login(
                                      userDetails.email, userDetails.password));
                                }
                              }),
                          const SizedBox(
                            height: 24,
                          ),
                          TextButton(
                              onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupPage()),
                                  ),
                              child:
                                  const Text("Do not have an account? Signup!"))
                        ],
                      ),
                    )),
              );
            },
          )),
    );
  }
}
