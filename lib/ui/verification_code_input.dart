import 'package:flutter/material.dart';

class VerificationCodeInput extends StatefulWidget {
  final void Function(String code) onVerificationCodeComplete;
  final String? initialValue;
  final bool? isSuccessful;
  const VerificationCodeInput(
      {super.key,
      required this.onVerificationCodeComplete,
      required this.isSuccessful,
      this.initialValue});

  @override
  State<VerificationCodeInput> createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  final List<TextEditingController> controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  List<FocusNode> focusNodes = [];

  void _onChanged(int index, String value) {
    if (value.isNotEmpty) {
      setState(() {
        controllers[index].text = value[value.length - 1];
      });

      if (index < controllers.length - 1) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else {
        String code = controllers.map((controller) => controller.text).join();
        widget.onVerificationCodeComplete(code);
        FocusScope.of(context).unfocus();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    focusNodes = List.generate(4, (_) => FocusNode());
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].text =
          widget.initialValue != null ? widget.initialValue![i] : '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 39.5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        ...List.generate(
          4,
          (index) => SizedBox(
            width: 50,
            child: TextFormField(
              controller: controllers[index],
              maxLength: 2, // Limit input to one character
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
              ),
              onTap: () => controllers[index].selection =
                  TextSelection.fromPosition(
                      TextPosition(offset: controllers[index].text.length)),
              focusNode: focusNodes[index],
              cursorWidth: 0,
              keyboardType: TextInputType.number,
              onChanged: (value) => _onChanged(index, value),
              decoration: InputDecoration(
                counter: const SizedBox.shrink(), // Hide the character counter
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: getBorderColor(context),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 13), // Adjust horizontal padding
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: getBorderColor(context),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: getBorderColor(context)),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Color getBorderColor(BuildContext context) {
    return widget.isSuccessful != null
        ? (widget.isSuccessful!
            ? const Color(0xFF00A15D)
            : const Color(0xFFE30000))
        : const Color(0xFFCFCFCF);
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    controllers.forEach((controller) => controller.dispose());
    focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }
}
