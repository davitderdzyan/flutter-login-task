import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final String value;
  final Function(String) onChanged;
  final bool isPassword;
  final bool isValid;
  final String placeholder;
  const CustomInput(this.value, this.onChanged,
      {super.key,
      this.isPassword = false,
      this.placeholder = '',
      this.isValid = true});

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 44,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: TextFormField(
          textInputAction: TextInputAction.next,
          obscureText: widget.isPassword ? !_isPasswordVisible : false,
          style: const TextStyle(fontSize: 15),
          strutStyle: const StrutStyle(fontSize: 15),
          initialValue: widget.value,
          decoration: InputDecoration(
              hintText: widget.placeholder,
              suffixIcon: (widget.isPassword)
                  ? IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Theme.of(context).primaryColor.withOpacity(0.6),
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 12, horizontal: 16), // Adjust padding as needed
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                      color: widget.isValid
                          ? Theme.of(context).hintColor
                          : Color(0xFFD70000))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                      color: widget.isValid
                          ? Theme.of(context).primaryColor
                          : Color(0xFFD70000))),
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                      color: (widget.isValid
                          ? Color(0xFFCCCCCC)
                          : Color(0xFFD70000))))),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
