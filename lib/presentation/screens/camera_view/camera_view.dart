import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/screens/camera_view/camera_view_model.dart/camera_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CameraView extends ConsumerWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (isImageTaking) =
        ref.watch(cameraViewModelProvider.select((value) => (value.isImageTaken)));
    return CameraAwesomeBuilder.awesome(
      sensorConfig: SensorConfig.single(
        sensor: Sensor.position(SensorPosition.front),
        flashMode: FlashMode.auto,
        aspectRatio: CameraAspectRatios.ratio_16_9,
        zoom: 0.0,
      ),
      saveConfig: SaveConfig.photo(
        pathBuilder: ref.read(cameraViewModelProvider.notifier).generateImagePath,
      ),
      enablePhysicalButton: true,
      previewFit: CameraPreviewFit.fitWidth,
      middleContentBuilder: (state) => const SizedBox.shrink(),
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
          AwesomeOrientedWidget(
            child: FloatingActionButton(
              heroTag: null,
              onPressed: isImageTaking
                  ? null
                  : () => takeImage(
                        photoState: state,
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
          )
        ],
      ),
    );
  }

  void takeImage({
    required CameraState photoState,
    required WidgetRef ref,
    required BuildContext context,
  }) {
    
  }
}
