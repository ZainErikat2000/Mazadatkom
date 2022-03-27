import 'package:flutter/material.dart';

class SocialSignInButton extends StatelessWidget {
  const SocialSignInButton({Key? key, required this.onPressed,
  required this.imageAsset, required this.buttonText, required this.buttonColor
  , required this.shadowColor, required this.textColor}) : super(key: key);
  final void Function()? onPressed;
  final String imageAsset;
  final String buttonText;
  final Color buttonColor;
  final Color? shadowColor;
  final Color textColor;


  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Opacity(
            child: Image.asset(
              imageAsset,
              width: 24,
              height: 24,
            ),
            opacity: 1.0,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            buttonText,
            style: TextStyle(fontSize: 16, color: textColor),
          ),
          const SizedBox(
            width: 16,
          ),
          Opacity(
            child: Image.asset(
              imageAsset,
              width: 24,
              height: 24,
            ),
            opacity: 0.0,
          ),
        ],
      ),
      style: TextButton.styleFrom(
          backgroundColor: buttonColor, shadowColor: shadowColor),
    );
  }
}
