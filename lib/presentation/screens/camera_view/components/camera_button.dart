import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_without_internet/presentation/screens/camera_view/camera_view_model.dart/camera_view_model.dart';

class CameraButton extends ConsumerWidget {
  final void Function() takeImage;
  const CameraButton({super.key, required this.takeImage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    final (isImageTaking, images) = ref.watch(
      cameraViewModelProvider.select(
        (value) => (
          value.isImageTaken,
          value.images,
        ),
      ),
    );
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: images.length < 6 ? null : Colors.grey[600],
      onPressed: (images.length < 6)
          ? isImageTaking
              ? null
              : takeImage
          : null,
      child: isImageTaking
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Icon(
              Icons.camera_alt,
              color: (images.length < 6) ? null : Colors.black,
            ),
    );
  }
}
