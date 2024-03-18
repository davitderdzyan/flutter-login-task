import 'dart:async';

import 'package:flutter/material.dart';

class ResendCode extends StatefulWidget {
  final void Function() onResend;

  const ResendCode({
    super.key,
    required this.onResend,
  });

  @override
  State<ResendCode> createState() => _ResendCodeState();
}

class _ResendCodeState extends State<ResendCode> {
  int _seconds = 20;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          setState(() {
            _seconds--;
          });
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Resend Code In 00:${(_seconds < 10 ? '0' : '') + _seconds.toString()} s',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontFamily: 'roboto',
            ),
          ),
          TextButton(
            onPressed: _seconds == 0 ? widget.onResend : null,
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  // Set text color based on button state
                  if (states.contains(MaterialState.disabled)) {
                    // Disabled state
                    return const Color(0xFFCCCCCC); // Change to desired color
                  }
                  return Theme.of(context).secondaryHeaderColor;
                },
              ),
            ),
            child: const Text(
              'Resend Code',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'roboto',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
}
