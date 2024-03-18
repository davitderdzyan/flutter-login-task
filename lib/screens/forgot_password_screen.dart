import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:login_task/screens/verification_screen.dart';

import '../ui/custom_app_bar.dart';
import '../ui/custom_button.dart';
import '../ui/custom_input.dart';
import '../ui/custom_label.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String _email = '';
  bool _isValid = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 14,
                ),
                const CustomAppBar('Forgot Password'),
                const SizedBox(
                  height: 23.65,
                ),
                const Text(
                  'Enter email address',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 20.35,
                ),
                const CustomLabel('Email'),
                CustomInput(_email, (value) {
                  setState(() {
                    _email = value;
                  });
                }, placeholder: 'user@gmail.com', isValid: _isValid),
                if (!_isValid)
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text(
                      'This is not a valid email format',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 12, color: Color(0xFFD70000)),
                    ),
                  )
              ],
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: CustomButton(
                onPressed: _email != ''
                    ? () {
                        if (EmailValidator.validate(_email)) {
                          setState(() {
                            _isValid = true;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerificationScreen(
                                _email,
                                VerficationType.passwordRecovery,
                              ),
                            ),
                          );
                        } else {
                          setState(() {
                            _isValid = false;
                          });
                        }
                      }
                    : null,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: const Text('Send'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
