import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  const ErrorMessage(
    this.message, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        message,
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 12, color: Color(0xFFD70000)),
      ),
    );
  }
}
