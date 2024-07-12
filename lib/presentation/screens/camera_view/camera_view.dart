import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_without_internet/presentation/common/components/container_image_component.dart';
import 'package:form_without_internet/presentation/screens/camera_view/camera_view_model.dart/camera_view_model.dart';
import 'package:form_without_internet/presentation/screens/camera_view/components/camera_button.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/form_view/form_view_model/form_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';
import 'package:form_without_internet/types/photo_type.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CameraView extends ConsumerStatefulWidget {
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
  ConsumerState<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends ConsumerState<CameraView> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // ref.read(cameraViewModelProvider.notifier).setPhotoType(widget.photoType);
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(cameraViewModelProvider.notifier).setPhotoType(widget.photoType);
      ref.read(cameraViewModelProvider.notifier).setImages(widget.images);
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    final (images) = ref.watch(
      cameraViewModelProvider.select(
        (value) => (value.images),
      ),
    );
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
          pathBuilder: (sensors) => ref
              .read(cameraViewModelProvider.notifier)
              .generateImagePath(sensors, widget.photoType),
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
        bottomActionsBuilder: (state) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (images.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: height * 0.2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    // primero, detectamos cuando el usuario acuesta el dispositivo
                    // si es así, rotamos la imagen
                    return ContainerImageComponent(
                      height: height * 0.18,
                      width: height * 0.18,
                      image: images[index],
                      onDelete: () {
                        ref.read(cameraViewModelProvider.notifier).deleteImage(index);
                        ref.read(formViewModelProvider.notifier).deleteImage(widget.index, index,
                            onDelete: (questions) {
                          final formIndex =
                              ref.read(formViewModelProvider.select((value) => value.formIndex));
                          ref
                              .read(listFormsViewModelProvider.notifier)
                              .getQuestions(questions, formIndex);
                        });
                      },
                    );
                  },
                ),
              ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                state.when(
                  onPhotoMode: (photoState) => AwesomeOrientedWidget(
                    child: CameraButton(
                      takeImage: () => takeImage(
                        photoState: photoState,
                        context: context,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }

  Future takeImage({
    required PhotoCameraState photoState,
    required BuildContext context,
  }) async {
    final isTaking = ref.read(cameraViewModelProvider.select((value) => value.isImageTaken));

    if (isTaking) return null;

    ref.read(cameraViewModelProvider.notifier).isTaking(true);

    try {
      // reducir el tamaño de la imagen a 100kb
      final result = await photoState.takePhoto();

      final path = result.when(
        single: (p0) => p0.file?.path,
        multiple: (p0) => null,
      );

      ref.read(cameraViewModelProvider.notifier).isTaking(false);
      if (!context.mounted) return;
      if (widget.photoType == PhotoType.fachadaSection) {
        Navigator.of(context).pop(path);
        return;
      }
      if (path == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error taking image'),
          ),
        );
        return;
      }
      ref.read(cameraViewModelProvider.notifier).addImage(path);
      final images = ref.watch(cameraViewModelProvider.select((value) => value.images));
      final questions = ref.read(formViewModelProvider.notifier).addImages(widget.index, images);
      final formIndex = ref.read(formViewModelProvider.select((value) => value.formIndex));
      ref.read(listFormsViewModelProvider.notifier).getQuestions(questions, formIndex);
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
