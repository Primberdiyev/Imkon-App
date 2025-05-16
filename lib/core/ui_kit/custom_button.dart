import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.textSize,
    required this.buttonColor,
    required this.textColor,
    this.function,
  });
  final String text;
  final double textSize;
  final Color buttonColor;
  final Color textColor;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: function,

      style: TextButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        fixedSize: Size(MediaQuery.of(context).size.width - 60, 60),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: textSize,
          color: textColor,
          fontFamily: 'myFirstFont',
        ),
      ),
    );
  }
}
