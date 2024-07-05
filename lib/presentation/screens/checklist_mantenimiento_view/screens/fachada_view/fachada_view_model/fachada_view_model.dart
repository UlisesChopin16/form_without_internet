import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fachada_view_model.freezed.dart';
part 'fachada_view_model.g.dart';

@freezed
class FachadaModel with _$FachadaModel {
  const factory FachadaModel({
    @Default('') String imagePath,
    @Default(false) bool isImageTaken,
    @Default('') String gerente,
    @Default('') String telefonoContacto,
  }) = _FachadaModel;
}

@riverpod
class FachadaViewModel extends _$FachadaViewModel {
  @override
  FachadaModel build() {
    return const FachadaModel();
  }
}
