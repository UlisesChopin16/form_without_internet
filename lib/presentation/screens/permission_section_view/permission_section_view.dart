import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionSectionView extends StatelessWidget {
  final Permission permission;
  final String explanation;
  final String title;
  final String explainSettings;
  final String path;

  const PermissionSectionView({
    super.key,
    required this.permission,
    required this.explanation,
    required this.title,
    required this.explainSettings,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(20),
          LottieBuilder.asset(
            path,
            width: 200,
            height: 200,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              explanation,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              explainSettings,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          const Gap(40),
          const ElevatedButton(
            onPressed: openAppSettings,
            child: Text('Abrir configuración'),
          ),
        ],
      ),
    );
  }
}
