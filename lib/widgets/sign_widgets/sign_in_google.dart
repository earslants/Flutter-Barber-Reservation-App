import 'package:flutter/material.dart';
import 'package:kuaforv1/screens/auth_screens/signup_screen.dart';

class SignInWithGoogle extends StatelessWidget {
  const SignInWithGoogle({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()));
      },
      child: Container(
        width: width * 0.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Ink(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)),
              child: Image.asset(
                'images/google.png',
                width: 20,
                height: 20,
              ),
            ),
            SizedBox(width: width / 25),
            Text(
              "Google ile giriş yap",
              style: TextStyle(
                color: Colors.black,
                fontSize: height / 50,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}