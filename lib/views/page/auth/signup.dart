import 'package:flutter/material.dart';
import 'package:space_client_app/data/models/auth/user_register.dart';
import 'package:space_client_app/data/viewmodels/auth.dart';
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
          body: SafeArea(
            maintainBottomViewPadding: true,
            top: false,
            child: Form(
                key: keyForm,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.all(20).copyWith(top: size.height * .1),
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
                      /*  const CustomTextInput(
                        hint: "Phone",
                        border: 16,
                        leading: Icons.phone,
                        type: TextInputType.phone,
                      ),
                      const SizedBox(height: 16), */
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

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(await AuthenticationUser.signUp(
                                    userRegister))));
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
