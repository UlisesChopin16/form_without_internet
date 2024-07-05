import 'package:camerawesome/camerawesome_plugin.dart';
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
    bool? isCameraReady,
  }) = _CameraModel;
}

@riverpod
class CameraViewModel extends _$CameraViewModel {
  @override
  CameraModel build() {
    return const CameraModel();
  }

  Future<CaptureRequest> generateImagePath(List<Sensor> sensors) async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/fotosFachada/${DateTime.now().millisecondsSinceEpoch}.jpg';
    print('path: $path');
    return SingleCaptureRequest(path, sensors.first);
  }

  void isTaking(bool isTaking) {
    state = state.copyWith(isImageTaken: isTaking);
  }
}
