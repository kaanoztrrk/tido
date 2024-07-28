// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class OTPTextField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const OTPTextField({
    super.key,
    required this.onChanged,
  });

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  late List<TextEditingController> controllers;
  late FocusNode currentFocusNode;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(4, (index) => TextEditingController());
    currentFocusNode = FocusNode();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    currentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        4,
        (index) => SizedBox(
          width: 75,
          child: TextField(
            controller: controllers[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            onChanged: (value) {
              if (value.isNotEmpty) {
                // Move focus to the next TextField
                if (index < 3) {
                  FocusScope.of(context).nextFocus();
                } else {
                  currentFocusNode.unfocus();
                }
                // Notify onChanged callback with concatenated OTP
                String otp =
                    controllers.map((controller) => controller.text).join();
                widget.onChanged(otp);
              } else {
                // Handle backspace to move focus back
                if (index > 0) {
                  FocusScope.of(context).previousFocus();
                }
              }
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 35),
              counter: Offstage(),
            ),
          ),
        ),
      ),
    );
  }
}
