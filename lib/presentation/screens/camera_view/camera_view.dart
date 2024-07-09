import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_without_internet/presentation/screens/camera_view/camera_view_model.dart/camera_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CameraView extends ConsumerStatefulWidget {
  const CameraView({super.key});

  @override
  ConsumerState<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends ConsumerState<CameraView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final (isImageTaking) =
        ref.watch(cameraViewModelProvider.select((value) => (value.isImageTaken)));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: CameraAwesomeBuilder.awesome(
        sensorConfig: SensorConfig.single(
          sensor: Sensor.position(SensorPosition.back),
          flashMode: FlashMode.auto,
          aspectRatio: CameraAspectRatios.ratio_16_9,
          zoom: 0.0,
        ),
        saveConfig: SaveConfig.photo(
          pathBuilder: ref.read(cameraViewModelProvider.notifier).generateImagePath,
          exifPreferences: ExifPreferences(saveGPSLocation: false),
        ),
        enablePhysicalButton: true,
        previewFit: CameraPreviewFit.fitWidth,
        // middleContentBuilder: (state) => const SizedBox.shrink(),
        topActionsBuilder: (state) => AwesomeTopActions(
          state: state,
          children: [
            AwesomeFlashButton(state: state),
            if (state is PhotoCameraState)
              AwesomeAspectRatioButton(
                state: state,
              ),
            const SizedBox.square(
              dimension: 50,
            )
          ],
        ),
        bottomActionsBuilder: (state) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state.when(
              onPhotoMode: (photoState) => AwesomeOrientedWidget(
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: isImageTaking
                      ? null
                      : () => takeImage(
                            photoState: photoState,
                            ref: ref,
                            context: context,
                          ),
                  child: isImageTaking
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.camera_alt),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future takeImage({
    required PhotoCameraState photoState,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    final isTaking = ref.read(cameraViewModelProvider.select((value) => value.isImageTaken));

    if (isTaking) return null;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    ref.read(cameraViewModelProvider.notifier).isTaking(true);

    try {
      final result = await photoState.takePhoto();
      final path = result.when(
        single: (p0) => p0.file?.path,
        multiple: (p0) => null,
      );

      if (!context.mounted) return;
      ref.read(cameraViewModelProvider.notifier).isTaking(false);
      Navigator.of(context).pop(path);
    } catch (e) {
      ref.read(cameraViewModelProvider.notifier).isTaking(false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('error'),
        ),
      );
    }
  }
}
