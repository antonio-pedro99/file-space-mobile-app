import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/blocs/auth/auth_bloc.dart';

import 'package:space_client_app/views/page/auth/login.dart';

import 'package:space_client_app/views/theme/colors.dart';
import 'package:space_client_app/views/widgets/button_text.dart';
import 'package:space_client_app/views/widgets/input_text.dart';

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

  String hashEmail(String email) {
    int end = email.indexOf("@") - 1;
    int start = 1;
    String hashed = email.replaceRange(start, end, "*" * 5);

    return hashed;
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
              if (state is AuthLoading) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                  "Confirming",
                  style: TextStyle(),
                )));
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      state.message,
                      style: const TextStyle(color: Colors.white),
                    )));
              } else if (state is AuthLoaded) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => LoginPage(
                              email: widget.email,
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
                          Text(
                              "We sent a confirmation code to ${hashEmail(widget.email)}"),
                          const SizedBox(height: 24),
                          CustomTextInput(
                            hint: "Enter the confirmation code",
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
                                /*   BlocProvider.of<AuthBloc>(context).add(
                                    ConfirmSignup(
                                        textCodeController.text, widget.email)); */
                              }
                            },
                          ),
                        ],
                      ),
                    )),
              );
            },
          )),
    );
  }
}
