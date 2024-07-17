import 'package:flutter/material.dart';

class LabelTextComponent extends StatelessWidget {
  final String label;
  final String text;
  final double fontSize;
  final Color colorText;
  final TextStyle? style;
  final TextAlign textAlign;
  const LabelTextComponent({
    super.key,
    required this.label,
    required this.text,
    this.fontSize = 14,
    this.style,
    this.textAlign = TextAlign.center,
    this.colorText = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
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
            style: style ?? TextStyle(
              color: colorText,
              fontSize: fontSize + 3,
            ),
          ),
        ],
      ),
    );
  }
}
