import 'package:flutter/material.dart';

class ButtonBaseComponent extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  const ButtonBaseComponent({super.key, required this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.black,
        elevation: 5,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
