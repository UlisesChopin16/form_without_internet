import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SavingDataComponent extends StatelessWidget {
  final bool isSaving;
  final bool isSaved;
  const SavingDataComponent({super.key, required this.isSaving, required this.isSaved});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSaving)
          const Row(
            children: [
              SizedBox.square(
                dimension: 30,
                child: CircularProgressIndicator(),
              ),
              Gap(10),
              Text('Guardando...'),
            ],
          ),
          if (isSaved)
            const Center(
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 35,
                  ),
                  Gap(10),
                  Text('Guardado'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
