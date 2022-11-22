// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:space_client_app/data/models/auth/user_register.dart';
import 'package:space_client_app/data/viewmodels/auth.dart';
import 'package:space_client_app/views/page/auth/login.dart';
import 'package:space_client_app/views/page/page_driver.dart';
import 'package:space_client_app/views/theme/colors.dart';
import 'package:space_client_app/views/widgets/button_text.dart';
import 'package:space_client_app/views/widgets/input_text.dart';
import 'package:space_client_app/app.dart';

class ConfirmRegistrationPage extends StatefulWidget {
  const ConfirmRegistrationPage({Key? key, required this.email})
      : super(key: key);
  final String email;
  @override
  State<ConfirmRegistrationPage> createState() =>
      _ConfirmRegistrationPageState();
}

class _ConfirmRegistrationPageState extends State<ConfirmRegistrationPage> {
  var keyForm = GlobalKey<FormState>();

  final textCodeController = TextEditingController();

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
                        hint: "Confirm Code",
                        border: 16,
                        leading: Icons.security,
                        controller: textCodeController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomButton(
                        text: "Confirm",
                        textColor: white,
                        color: purple,
                        widget: size.width * .5,
                        onTap: () async {
                          if (keyForm.currentState!.validate()) {
                            var result = await AuthenticationUser.confirm(
                                widget.email, textCodeController.text);
                            if (!result["status"]) {
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
                                      builder: (context) => LoginPage(
                                            email: widget.email,
                                          )),
                                  (route) => false);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                )),
          )),
    );
  }
}
