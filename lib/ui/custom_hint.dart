import 'package:flutter/material.dart';

class CustomHint extends StatelessWidget {
  final String message;
  const CustomHint(
    this.message, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Text(
        message,
        style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).primaryColor.withOpacity(0.55)),
        overflow: TextOverflow.clip,
      ),
    );
  }
}
