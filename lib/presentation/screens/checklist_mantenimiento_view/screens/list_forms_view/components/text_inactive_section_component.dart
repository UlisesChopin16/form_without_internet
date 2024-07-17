import 'package:flutter/material.dart';

class TextInactiveSectionComponent extends StatelessWidget {
  const TextInactiveSectionComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Esta área no aplica para esta sucursal',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}