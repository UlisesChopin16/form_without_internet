import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/screens/permission_section_view/permission_section_view.dart';
import 'package:form_without_internet/presentation/screens/permission_section_view/permission_section_view_model/permission_section_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionCameraSection extends ConsumerStatefulWidget {
  final Widget child;
  final String explanation;
  const PermissionCameraSection({
    super.key,
    required this.child,
    required this.explanation,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PermissionCameraSectionState();
}

class _PermissionCameraSectionState extends ConsumerState<PermissionCameraSection>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // this is import for determine the state of the permission
    // remove circle progress bar
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(permissionSectionViewModelProvider.notifier).evaluateCameraPermission();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // every time the app is resumed, the permission is evaluated
    // this for that the permission may have been changed in the settings

    if (state == AppLifecycleState.resumed) {
      ref.read(permissionSectionViewModelProvider.notifier).evaluateCameraPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasPermission =
        ref.watch(permissionSectionViewModelProvider.select((value) => value.hasCameraPermission));

    if (hasPermission == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }      

    if (!hasPermission) {
      return PermissionSectionView(
        permission: Permission.camera,
        explanation: widget.explanation,
        title: "Permiso necesario",
        explainSettings: 'Por favor, habilite el permiso de la cámara en la configuracion',
        path: 'assets/img/camera.json',
      );
    }

    return widget.child;
  }
}
