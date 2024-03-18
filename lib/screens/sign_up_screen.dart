import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:login_task/auth_service.dart';
import 'package:login_task/screens/sign_in_screen.dart';
import 'package:login_task/screens/verification_screen.dart';
import 'package:provider/provider.dart';

import '../auth_provider.dart';
import '../ui/continue_with_google.dart';
import '../ui/custom_button.dart';
import '../ui/custom_hint.dart';
import '../ui/custom_input.dart';
import '../ui/custom_label.dart';
import '../ui/custom_title.dart';
import '../ui/error_message.dart';
import '../ui/privacy_policy.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _email = '';
  bool _loading = false;
  String? _error;
  bool _isEmailValid = true;
  bool _isUsernameValid = true;
  bool _isPasswordValid = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? buildLoading(context)
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  height: MediaQuery.sizeOf(context).height -
                      MediaQuery.viewInsetsOf(context).bottom / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildUserInputs(context),
                      buildActions(context),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Column buildActions(BuildContext context) {
    return Column(
      children: [
        Container(
            width: MediaQuery.sizeOf(context).width,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: CustomButton(
              onPressed: onSignUp,
              backgroundColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: const Text('Sign Up'),
            )),
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
                'Already have an account?',
                style: TextStyle(fontSize: 14),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()));
                },
                child: Text(
                  'Sign in',
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).secondaryHeaderColor),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Column buildUserInputs(BuildContext context) {
    return Column(
      children: [
        const CustomTitle('Sign Up'),
        const CustomLabel('Username'),
        CustomInput(
          _username,
          (value) {
            setState(() {
              _username = value;
            });
          },
          placeholder: 'username',
          isValid: _isUsernameValid,
        ),
        if (!_isUsernameValid) ...[
          const SizedBox(
            height: 2,
          ),
          const ErrorMessage('Username should be at least 3 characters long')
        ],
        const SizedBox(height: 2),
        const CustomHint(
            'Please consider that you will not be able to change the username'),
        const SizedBox(height: 24),
        const CustomLabel('Email'),
        CustomInput(
          _email,
          (value) {
            setState(() {
              _email = value;
            });
          },
          placeholder: 'user@gmail.com',
          isValid: _isEmailValid,
        ),
        if (!_isEmailValid) ...[
          const SizedBox(
            height: 2,
          ),
          const ErrorMessage('This is not a valid email format')
        ],
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
          placeholder: '**********',
          isValid: _isPasswordValid,
        ),
        if (!_isPasswordValid) ...[
          const SizedBox(
            height: 2,
          ),
          const ErrorMessage('Password should be at least 6 characters long.')
        ],
        if (_error != null) ...[
          const SizedBox(
            height: 20,
          ),
          ErrorMessage(_error!)
        ],
        const SizedBox(
          height: 24.5,
        ),
        const PrivacyPolicy(),
      ],
    );
  }

  Center buildErrorMessage() {
    return Center(
      child: Text(
        _error!,
      ),
    );
  }

  Center buildLoading(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).secondaryHeaderColor,
      ),
    );
  }

  void onSignUp() {
    setState(() {
      _isEmailValid = EmailValidator.validate(_email);
      _isUsernameValid = _username.length > 2;
      _isPasswordValid = _password.length > 5;

      if (_isEmailValid && _isUsernameValid && _isPasswordValid) {
        setState(() {
          _loading = true;
        });
        AuthService.signUp(_username, _password, _email).then((Response value) {
          bool success = jsonDecode(value.body)['success'];
          setState(() => _loading = false);
          if (success) {
            Provider.of<AuthProvider>(context, listen: false)
                .signIn(_email, _password);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerificationScreen(
                  _email,
                  VerficationType.signUp,
                ),
              ),
            );
          } else {
            setState(
              () {
                _loading = false;
                _error = 'Username or Email exists';
              },
            );
          }
          ;
        }).catchError(
            (error) => setState(() => {error = 'Something went wrong'}));
      }
    });
  }
}
