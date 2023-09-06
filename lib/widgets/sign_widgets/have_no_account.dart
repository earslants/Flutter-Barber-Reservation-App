import 'package:flutter/material.dart';

class CreateAccount extends StatelessWidget {

  final String fText;
  final String lText;
  final Route<dynamic> myRoute;

  const CreateAccount({
    super.key, required this.fText, required this.lText, required this.myRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          fText,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        const SizedBox(width: 3),
        GestureDetector(
          onTap: () {
            Navigator.push(context, myRoute);
          },
          child: Text(
            lText,
            style: const TextStyle(
              color: Color(0xFF0984E3),
            ),
          ),
        ),
      ],
    );
  }
}
