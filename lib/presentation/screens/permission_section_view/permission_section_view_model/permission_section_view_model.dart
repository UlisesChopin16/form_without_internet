import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_section_view_model.freezed.dart';
part 'permission_section_view_model.g.dart';

@freezed
class PermissionModel with _$PermissionModel {
  const factory PermissionModel({
    @Default(null) bool? hasCameraPermission,
  }) = _PermissionModel;
}


@riverpod
class PermissionSectionViewModel extends _$PermissionSectionViewModel {

  @override
  PermissionModel build() {
    return const PermissionModel();
  }


  Future<void> evaluateCameraPermission() async {
    final isGranted = await Permission.camera.status.isGranted;
    state = state.copyWith(hasCameraPermission: isGranted);
  }
}