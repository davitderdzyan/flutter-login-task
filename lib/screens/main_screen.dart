import 'package:flutter/material.dart';
import 'package:login_task/screens/sign_in_screen.dart';
import 'package:login_task/screens/sign_up_screen.dart';

import '../ui/custom_button.dart';
import '../ui/image_slider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ImageSlider(),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 20, top: 40),
                child: CustomButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()),
                    );
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: const Text('Sign In'),
                )),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: CustomButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()),
                    );
                  },
                  backgroundColor: Colors.white,
                  textColor: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).primaryColor,
                  child: const Text('Sign Up'),
                ))
          ],
        ),
      ),
    );
  }
}
