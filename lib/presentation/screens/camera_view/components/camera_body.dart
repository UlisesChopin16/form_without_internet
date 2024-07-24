import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
import 'package:flutter/material.dart';
import 'package:form_without_internet/app/extensions.dart';
import 'package:form_without_internet/presentation/common/components/container_image_component.dart';
import 'package:form_without_internet/presentation/screens/camera_view/camera_view_model.dart/camera_view_model.dart';
import 'package:form_without_internet/presentation/screens/camera_view/components/camera_button.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/fachada_view/fachada_view_model/fachada_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/form_view/form_view_model/form_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';
import 'package:form_without_internet/types/photo_type.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CameraBody extends ConsumerStatefulWidget {
  final PhotoType photoType;
  final int index;
  final List<String> images;
  const CameraBody({
    super.key,
    required this.photoType,
    this.images = const [],
    this.index = 0,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CameraViewState();
}

class _CameraViewState extends ConsumerState<CameraBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cameraViewModelProvider.notifier).setPhotoType(widget.photoType);
      ref.read(cameraViewModelProvider.notifier).setImages(widget.images);
    });
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    final double height = MediaQuery.of(context).size.height;

    final (imagesr) = ref.watch(
      cameraViewModelProvider.select(
        (value) => (value.images),
      ),
    );
    return RotatedBox(
      quarterTurns: orientation == Orientation.landscape ? 3 : 0,
      child: CameraAwesomeBuilder.awesome(
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
        bottomActionsBuilder: (state) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (imagesr.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: height * 0.2,
                child: ListView.builder(
                  padding: EdgeInsets.only(top: orientation == Orientation.landscape ? 10 : 0),
                  scrollDirection: Axis.horizontal,
                  itemCount: imagesr.length,
                  itemBuilder: (context, index) {
                    // primero, detectamos cuando el usuario acuesta el dispositivo
                    // si es así, rotamos la imagen
                    return RotatedBox(
                      quarterTurns: orientation == Orientation.landscape ? 1 : 0,
                      child: ContainerImageComponent(
                        height: height * 0.18,
                        width: height * 0.18,
                        image: imagesr[index],
                        onTap: () {
                          if (imagesr.length == 1) {
                            context.showFullImage(
                              image: imagesr[index],
                              onDelete: (indexImage) {
                                onDelete(index);
                                context.pop();
                              },
                            );
                            return;
                          }
                          context.showFullImage(
                            images: imagesr,
                            index: index,
                            onDelete: onDelete,
                          );
                        },
                        onDelete: () => onDelete(index),
                      ),
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

  void onDelete(int index) {
    ref.read(cameraViewModelProvider.notifier).deleteImage(index);

    if (widget.photoType == PhotoType.fachadaSection) {
      ref.read(fachadaViewModelProvider.notifier).setImagePath('');
      return;
    }

    ref.read(formViewModelProvider.notifier).deleteImage(widget.index, index,
        onDelete: (questions) {
      final formIndex = ref.read(formViewModelProvider.select((value) => value.formIndex));
      ref.read(listFormsViewModelProvider.notifier).getQuestions(questions, formIndex);
    });
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
      if (path == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error taking image'),
          ),
        );
        return;
      }
      if (widget.photoType == PhotoType.fachadaSection) {
        ref.read(fachadaViewModelProvider.notifier).setImagePath(path);
        ref.read(cameraViewModelProvider.notifier).setImages([path]);
        return;
      }
      ref.read(cameraViewModelProvider.notifier).addImage(path);
      final imagesr = ref.watch(cameraViewModelProvider.select((value) => value.images));
      final questions = ref.read(formViewModelProvider.notifier).addImages(widget.index, imagesr);
      final formIndex = ref.read(formViewModelProvider.select((value) => value.formIndex));
      ref.read(listFormsViewModelProvider.notifier).getQuestions(questions, formIndex);
      ref.read(formViewModelProvider.notifier).putInSaved();
    } catch (e) {
      if (!context.mounted) return;
      ref.read(cameraViewModelProvider.notifier).isTaking(false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('error'),
        ),
      );
    }
  }
}
