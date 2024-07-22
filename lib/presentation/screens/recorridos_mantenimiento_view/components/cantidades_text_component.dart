import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/common/components/center_text_component.dart';

class CantidadesTextComponent extends StatelessWidget {
  final String text;
  final Color color;
  final void Function() onTap;
  const CantidadesTextComponent({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: color,
          elevation: 3,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        child: CenterTextComponent(
          text: text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
