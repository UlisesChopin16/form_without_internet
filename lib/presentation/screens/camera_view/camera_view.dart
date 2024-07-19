import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/screens/camera_view/components/camera_body.dart';
import 'package:form_without_internet/presentation/screens/permission_section_view/permission_camera_section/permission_camera_section.dart';
import 'package:form_without_internet/types/photo_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CameraView extends ConsumerWidget {
  final PhotoType photoType;
  final int index;
  final List<String> images;
  const CameraView({
    super.key,
    required this.photoType,
    this.images = const [],
    this.index = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: SafeArea(
        child: PermissionCameraSection(
          explanation: 'Se necesita el permiso de la cámara para poder tomar fotos',
          child: CameraBody(
            photoType: photoType,
            images: images,
            index: index,
          ),
        ),
      ),
    );
  }
}
