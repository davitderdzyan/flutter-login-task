import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_task/auth_provider.dart';
import 'package:login_task/auth_service.dart';
import 'package:login_task/screens/forgot_password_screen.dart';
import 'package:login_task/screens/logged_in_screen.dart';
import 'package:login_task/screens/sign_up_screen.dart';
import 'package:provider/provider.dart';

import '../ui/continue_with_google.dart';
import '../ui/custom_button.dart';
import '../ui/custom_input.dart';
import '../ui/custom_label.dart';
import '../ui/custom_title.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  String _email = '';
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height -
                MediaQuery.of(context).viewInsets.bottom / 1.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const CustomTitle('Sign In'),
                    const CustomLabel('Email'),
                    CustomInput(
                      _email,
                      (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      placeholder: 'user@gmail.com',
                    ),
                    const SizedBox(height: 24),
                    const CustomLabel('Password'),
                    CustomInput(
                      _password,
                      (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      isPassword: true,
                      placeholder: 'Enter 6 digit code',
                    ),
                    if (_hasError) ...[
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Credentials are incorrect!',
                            style: TextStyle(
                                color: Color(0xFFD31510),
                                fontSize: 15,
                                fontFamily: 'roboto'),
                          ),
                        ),
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (content) =>
                                      const ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Privacy Policy',
                              style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: CustomButton(
                        onPressed: () {
                          AuthService.signIn(_email, _password).then((value) {
                            if (!jsonDecode(value.body)['success']) {
                              setState(() {
                                _hasError = true;
                              });
                            } else {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .signIn(_email, _password);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LoggedInScreen()),
                                (Route<dynamic> route) => false,
                              );
                            }
                          });
                        },
                        backgroundColor: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: const Text('Sign In'),
                      ),
                    ),
                    const SizedBox(height: 20.5),
                    const ContinueWithGoogle(),
                    const SizedBox(height: 20.5),
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(fontSize: 14),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
