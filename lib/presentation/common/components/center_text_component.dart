import 'package:flutter/material.dart';

class CenterTextComponent extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const CenterTextComponent({
    super.key,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: style,
      ),
    );
  }
}