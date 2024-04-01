import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sign_in_button/sign_in_button.dart';

import '../custom_widgets/custom_shape.dart';
import '../custom_widgets/my_text_field_widget.dart';
import '../utils/routes/route_names.dart';
import '../view-models/firebase_auth_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Consumer<FirebaseAuthViewModel>(
        builder: (context, provider, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomShapeWidget(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        MyTextFieldWidget(
                          hintText: "Email or Phone",
                          prefixIcon: const Icon(Icons.person_outline_rounded),
                          controller: emailController,
                          focusNode: emailFocusNode,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return "Please Enter Email or Phone";
                            }
                            if (!EmailValidator.validate(p0)) {
                              return "Please Enter Email or Phone";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextFieldWidget(
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          isPassword: true,
                          controller: passwordController,
                          focusNode: passwordFocusNode,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return "Please Enter Password";
                            } else if (p0.length < 6) {
                              return "Password must be at least 6 characters";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        provider.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    provider.loginUser(
                                      context: context,
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                    log("Login Success");
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width, 46),
                                    backgroundColor: const Color(0xff3b5998),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 2),
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Expanded(
                          child: SizedBox(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    margin: const EdgeInsets.only(right: 10),
                    width: MediaQuery.of(context).size.width * 0.25,
                    color: Colors.black12,
                  ),
                  const Text(
                    "or continue with",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                    ),
                  ),
                  Container(
                      height: 1,
                      margin: const EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width * 0.25,
                      color: Colors.black12)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: SignInButton(
                  Buttons.google,
                  text: "Sign up with Google",
                  onPressed: () {
                    FirebaseAuthViewModel().signInWithGoogle(
                      context: context,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?   ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, RouteNames.register),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              )
            ],
          );
        },
      )),
    );
  }
}
