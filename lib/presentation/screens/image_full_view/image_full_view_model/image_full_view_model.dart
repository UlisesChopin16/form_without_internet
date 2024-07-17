import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_full_view_model.freezed.dart';
part 'image_full_view_model.g.dart';

@freezed
class ImageFullModel with _$ImageFullModel {
  const factory ImageFullModel({
    @Default('') String image,
    @Default(0) int index,
    @Default([]) List<String> images,
  }) = _ImageFullModel;
}

@riverpod
class ImageFullViewModel extends _$ImageFullViewModel {
  @override
  ImageFullModel build() {
    return const ImageFullModel();
  }

  void setData({
    required String image,
    required List<String> images,
    required int index,
  }) {
    state = state.copyWith(
      image: image,
      images: images,
      index: index,
    );
  }

  void deleteImage({
    int indexI = 0,
    required void Function(int)? onDelete,
  }) {
    if (state.images.isNotEmpty) {
      state = state.copyWith(
        images: [...state.images]..removeAt(indexI),
        index: indexI == state.images.length - 1 ? indexI - 1 : indexI,
      );
      onDelete?.call(indexI);
      return;
    }
    onDelete?.call(indexI);
  }

  void onChangeImage(int index) {
    state = state.copyWith(index: index);
  }
}
