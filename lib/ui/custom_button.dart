import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final void Function()? onPressed;
  final Widget child;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    required this.child,
    this.borderColor,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.backgroundColor,
        foregroundColor: widget.textColor,
        disabledForegroundColor: widget.textColor.withOpacity(0.8),
        disabledBackgroundColor: Color(0x00000000).withOpacity(0.45),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        textStyle: const TextStyle(
          fontSize: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            4,
          ),
          side: BorderSide(
            color: widget.borderColor != null
                ? widget.borderColor!
                : Color.fromRGBO(0, 0, 0, 0),
            width: 2,
          ),
        ),
      ),
      child: widget.child,
    );
  }
}
