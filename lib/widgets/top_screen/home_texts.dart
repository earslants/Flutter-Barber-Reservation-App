import 'package:flutter/material.dart';

class HomeText extends StatelessWidget {
  const HomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Çevrendeki\n", // İlk satır
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withOpacity(0.8),
              fontStyle: FontStyle.italic,
            ),
          ),
          TextSpan(
            text: "Kuaförleri\n", // İkinci satır
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withOpacity(0.8),
              fontStyle: FontStyle.italic,
            ),
          ),
          TextSpan(
            text: "Keşfet", // İkinci satır
            style: TextStyle(
              fontSize: 40,
              color: Colors.white.withOpacity(0.8),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

