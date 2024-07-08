import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fachada_view_model.freezed.dart';
part 'fachada_view_model.g.dart';

@freezed
class FachadaModel with _$FachadaModel {
  const factory FachadaModel({
    @Default('') String imagePath,
    @Default(false) bool isImageTaken,
    @Default('Laboratorio Medico del CHOPO') String marca,
    @Default('QUERETARO') String region,
    @Default('Consultorio') String tipoSucursal,
    @Default('') String gerente,
    @Default('') String telefonoContacto,
  }) = _FachadaModel;
}

@riverpod
class FachadaViewModel extends _$FachadaViewModel implements FachadaViewModelInput{
  @override
  FachadaModel build() {
    return const FachadaModel();
  }

  @override
  void setImagePath(String path) {
    state = state.copyWith(imagePath: path);
  }

  @override
  void isTaking(bool isTaking) {
    state = state.copyWith(isImageTaken: isTaking);
  }

  @override
  void onChangeGerente(String gerente) async {
    state = state.copyWith(gerente: gerente);
  }

  @override
  void onChangeTelefonoContacto(String telefonoContacto) async {
    state = state.copyWith(telefonoContacto: telefonoContacto);
  }
}

abstract class FachadaViewModelInput {
  void setImagePath(String path);
  void isTaking(bool isTaking);
  void onChangeGerente(String gerente);
  void onChangeTelefonoContacto(String telefonoContacto);
}
