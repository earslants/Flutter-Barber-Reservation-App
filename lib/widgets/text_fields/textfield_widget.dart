import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key ? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: width * 0.8,
      decoration: BoxDecoration(
        color: const Color(0x00d9d9d9).withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}