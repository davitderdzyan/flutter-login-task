import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:login_task/auth_service.dart';
import 'package:login_task/screens/logged_in_screen.dart';
import 'package:login_task/screens/password_recovery_screen.dart';
import '../ui/custom_app_bar.dart';
import '../ui/resend_code.dart';
import '../ui/verification_code_input.dart';

enum VerficationType { signUp, passwordRecovery }

class VerificationScreen extends StatefulWidget {
  final String email;
  final VerficationType type;
  const VerificationScreen(this.email, this.type, {super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  List<FocusNode> focusNodes = [];
  bool _isVerified = false;
  bool _isSuccessful = false;
  bool _isResendCode = true;
  String? _code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: _isResendCode
          ? FutureBuilder(
              builder: (context, snapshot) {
                _isResendCode = false;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Theme.of(context).secondaryHeaderColor,
                  ));
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Center(
                      child: Text('Something went wrong. \nTry again later'));
                } else {
                  return buildVerificationData();
                }
              },
              future: AuthService.sendVerificationCode(widget.email),
            )
          : buildVerificationData(),
    ));
  }

  Column buildVerificationData() {
    return Column(
      key: GlobalKey(),
      children: [
        const SizedBox(
          height: 14,
        ),
        const CustomAppBar('Verify Your Account'),
        const SizedBox(
          height: 23.65,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 39.5),
          child: Text(
            'Please enter the 4 - digit verification code we\n sent via mail:',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        VerificationCodeInput(
          onVerificationCodeComplete: (code) => {
            AuthService.verifyVerificationCode(widget.email, code)
                .then((Response value) {
              setState(() {
                _code = code;
                _isVerified = true;

                if (jsonDecode(value.body)['data'] != null) {
                  _isSuccessful = true;
                  Future.delayed(
                      const Duration(seconds: 1),
                      () => {
                            if (widget.type == VerficationType.passwordRecovery)
                              {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PasswordRecoveryScreen(),
                                  ),
                                )
                              }
                            else
                              {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoggedInScreen()),
                                  (Route<dynamic> route) =>
                                      false, // Stop removing when reaching the MainScreen
                                )
                              }
                          });
                } else {
                  _isSuccessful = false;
                }
              });
            }),
          },
          isSuccessful: _isVerified ? _isSuccessful : null,
          initialValue: _code,
        ),
        if (_isVerified && !_isSuccessful) ...[
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.65),
            child: Text(
              'Incorrect Code',
              style: TextStyle(color: Color(0xFFD31510), fontSize: 15),
            ),
          ),
        ],
        const SizedBox(height: 30),
        ResendCode(
          onResend: () {
            setState(() {
              _isResendCode = true;
            });
          },
        )
      ],
    );
  }
}
