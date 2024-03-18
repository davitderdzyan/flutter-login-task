import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.25, right: 10.25),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
            children: [
              const TextSpan(
                text: 'By continuing, you agree to our ',
              ),
              TextSpan(
                text: 'Terms of Service',
                style: Theme.of(context).textTheme.labelLarge,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Handle click action for "Terms of Service"
                    print('Terms of Service clicked');
                  },
              ),
              const TextSpan(
                text: ' Acknowledge that you have our ',
              ),
              TextSpan(
                text: 'Privacy Policy ',
                style: Theme.of(context).textTheme.labelLarge,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Handle click action for "Privacy Policy"
                    print('Privacy Policy clicked');
                  },
              ),
              const TextSpan(
                text: 'and to learn how we collect, use, and share your data.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
