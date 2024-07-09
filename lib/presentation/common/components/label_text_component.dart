import 'package:flutter/material.dart';

class LabelTextComponent extends StatelessWidget {
  final String label;
  final String text;
  final double fontSize;
  final Color colorText;
  const LabelTextComponent({
    super.key,
    required this.label,
    required this.text,
    required this.fontSize,
    this.colorText = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: text,
            style: TextStyle(
              color: colorText,
              fontSize: fontSize + 3,
            ),
          ),
        ],
      ),
    );
  }
}
