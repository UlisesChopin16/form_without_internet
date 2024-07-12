import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:form_without_internet/types/photo_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'camera_view_model.freezed.dart';
part 'camera_view_model.g.dart';

@freezed
class CameraModel with _$CameraModel {
  const factory CameraModel({
    @Default(false) bool isImageTaken,
    @Default('') String imagePath,
    @Default(null) PhotoType? photoType,
    @Default([]) List<String> images,
    bool? isCameraReady,
  }) = _CameraModel;
}

@riverpod
class CameraViewModel extends _$CameraViewModel {
  @override
  CameraModel build() {
    return const CameraModel();
  }

  void setPhotoType(PhotoType photoType) {
    state = state.copyWith(photoType: photoType);
  } 

  setImages(List<String> images) {
    state = state.copyWith(images: images);
  }

  Future<CaptureRequest> generateImagePath(List<Sensor> sensors, PhotoType type) async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/fotosFachada-${DateTime.now().millisecondsSinceEpoch}.jpg';
    return SingleCaptureRequest(path, sensors.first);
  }

  void addImage(String imagePath) {
    if (state.images.length < 6) {
      state = state.copyWith(images: [...state.images, imagePath]);
    }
  }

  List<String> deleteImage(int index) {
    final List<String> newImages = List.from(state.images);
    newImages.removeAt(index);
    state = state.copyWith(images: newImages);
    return newImages;
  }

  void isTaking(bool isTaking) {
    state = state.copyWith(isImageTaken: isTaking);
  }
}
