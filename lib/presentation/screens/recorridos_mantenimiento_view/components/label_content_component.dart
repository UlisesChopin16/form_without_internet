import 'package:flutter/material.dart';

class LabelContentComponent extends StatelessWidget {
  final String label;
  final Widget content;
const LabelContentComponent({
    super.key,
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        content,
      ],
    );
  }
}
