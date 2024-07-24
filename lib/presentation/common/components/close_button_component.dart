import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CloseButtonComponent extends StatelessWidget {
  final void Function()? onPressed;
  const CloseButtonComponent({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        backgroundColor: Colors.blue,
        iconColor: Colors.white,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      ),
      onPressed: () {
        onPressed?.call();
        context.pop(true);
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.close),
          Gap(5),
          Text('Cerrar'),
        ],
      ),
    );
  }
}
