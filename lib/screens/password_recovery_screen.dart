import 'package:flutter/material.dart';
import 'package:login_task/screens/main_screen.dart';
import 'package:login_task/ui/custom_app_bar.dart';
import 'package:login_task/ui/custom_input.dart';
import 'package:login_task/ui/custom_label.dart';

import '../ui/custom_button.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  String _password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const CustomAppBar('Reset Password'),
                const SizedBox(
                  height: 20,
                ),
                const CustomLabel('Enter new password'),
                CustomInput(
                  _password,
                  (password) => setState(() {
                    _password = password;
                  }),
                  isPassword: true,
                ),
                if (_password.length != 0) ...[
                  const SizedBox(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _password.length > 5 ? 'Looks Good' : 'Too short',
                          style: TextStyle(
                              color: _password.length > 5
                                  ? const Color(0xFF169B00)
                                  : const Color(0xFFD31510),
                              fontSize: 12),
                        ),
                        _password.length > 5
                            ? const Icon(
                                Icons.check,
                                size: 17,
                                color: Color(0xFF169B00),
                              )
                            : const Icon(
                                Icons.close,
                                size: 17,
                                color: Color(0xFFD31510),
                              )
                      ],
                    ),
                  ),
                ],
              ],
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: CustomButton(
                onPressed: _password.length > 5
                    ? () {
                        FocusScope.of(context).unfocus();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()),
                          (Route<dynamic> route) => false,
                        );
                      }
                    : null,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: const Text('Reset Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
