import 'package:flutter/material.dart';

class MarkerCardComponent extends StatelessWidget {
  final Color color;
  final Widget? markerChild;
  final Widget child;
  const MarkerCardComponent({
    super.key,
    this.markerChild,
    this.color = Colors.black,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        elevation: 5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.all(markerChild != null ? 2 : 6),
              child: markerChild,
            ),
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
