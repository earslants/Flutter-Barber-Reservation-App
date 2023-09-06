import 'package:flutter/material.dart';
import 'package:kuaforv1/widgets/top_screen/details_button.dart';
import 'package:kuaforv1/widgets/top_screen/home_texts.dart';

class TopScreenWidget extends StatelessWidget {

  final String buttonText;
  final VoidCallback onTap;
  const TopScreenWidget({
    super.key,
    required this.height,
    required this.width, required this.buttonText, required this.onTap,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height / 2,
      width: width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        image: DecorationImage(
          image: AssetImage("images/firstBarber.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const SearchBarWidget(),
          Padding(
            padding: EdgeInsets.only(left: 20, top: height / 5),
            child: const HomeText(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 10),
            child: DetailsButton(buttonText: buttonText, onTap: onTap),
          ),
        ],
      ),
    );
  }
}

