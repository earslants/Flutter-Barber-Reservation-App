import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class DetailsButton extends StatelessWidget {

  final String buttonText;
  final VoidCallback onTap;

  const DetailsButton({
    super.key, required this.buttonText, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 125,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.white.withOpacity(0.7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              LineAwesomeIcons.angle_right,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}
