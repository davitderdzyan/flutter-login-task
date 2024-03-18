import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  final String text;
  const CustomLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 10, bottom: 5),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
