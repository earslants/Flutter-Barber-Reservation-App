import 'package:flutter/material.dart';
import 'package:kuaforv1/widgets/text_fields/textfield_widget.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const RoundedInputField({
    required this.hintText,
    required this.icon,
    required this.onChanged,
    required this.keyboardType,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.black),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
