import 'package:flutter/material.dart';

class DetailsTextWidget extends StatelessWidget {
  final String title;
  final FontWeight fontWeight;
  final double fontSize;

  const DetailsTextWidget({
    super.key, required this.title, required this.fontWeight, required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
