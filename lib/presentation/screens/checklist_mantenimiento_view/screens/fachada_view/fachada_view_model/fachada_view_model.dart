import 'dart:convert';

import 'package:form_without_internet/app/app_preferences.dart';
import 'package:form_without_internet/app/dep_inject.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fachada_view_model.freezed.dart';
part 'fachada_view_model.g.dart';

@freezed
class FachadaModel with _$FachadaModel {
  const FachadaModel._();

  const factory FachadaModel({
    @Default(false) bool isLoading,
    @Default(false) bool isImageTaken,
    @Default(false) bool isResume,
    @Default('') String imagePath,
    @Default('') String folio,
    @Default('Laboratorio Medico del CHOPO') String marca,
    @Default('QUERETARO') String region,
    @Default('Consultorio') String tipoSucursal,
    @Default('') String gerente,
    @Default('') String telefonoContacto,
  }) = _FachadaModel;

  factory FachadaModel.fromJson(Map<String, dynamic> json) => _$FachadaModelFromJson(json);

  String toEncode() => json.encode(
        FachadaModel(
          folio: folio,
          imagePath: imagePath,
          marca: marca,
          region: region,
          tipoSucursal: tipoSucursal,
          gerente: gerente,
          telefonoContacto: telefonoContacto,
        ).toJson(),
      );
}

@riverpod
class FachadaViewModel extends _$FachadaViewModel implements FachadaViewModelInput {
  final AppPreferences _preferences = instance<AppPreferences>();

  @override
  FachadaModel build() {
    return const FachadaModel();
  }

  @override
  void getFachada(String folio, bool isResume) async {
    state = state.copyWith(
      isLoading: true,
      folio: folio,
      isResume: isResume,
    );
    final data = _preferences.getFachada(folio);
    if (data.isNotEmpty) {
      final fachada = FachadaModel.fromJson(json.decode(data));
      state = state.copyWith(
        imagePath: fachada.imagePath,
        marca: fachada.marca,
        region: fachada.region,
        tipoSucursal: fachada.tipoSucursal,
        gerente: fachada.gerente,
        telefonoContacto: fachada.telefonoContacto,
      );
    }

    state = state.copyWith(
      isLoading: false,
    );
  }

  setIsResume(bool isResume) {
    state = state.copyWith(isResume: isResume);
  }

  @override
  void setImagePath(String path) async {
    state = state.copyWith(imagePath: path);
    await _preferences.setFachada(state.folio, state.toEncode());
  }

  @override
  void isTaking(bool isTaking) {
    state = state.copyWith(isImageTaken: isTaking);
  }

  @override
  void onChangeGerente(String gerenteC) async {
    state = state.copyWith(gerente: gerenteC);
    await _preferences.setFachada(state.folio, state.toEncode());
  }

  @override
  void onChangeTelefonoContacto(String telefonoContactoC) async {
    state = state.copyWith(telefonoContacto: telefonoContactoC);
    await _preferences.setFachada(state.folio, state.toEncode());
  }
}

abstract class FachadaViewModelInput {
  void getFachada(String folio, bool isResume);
  void setImagePath(String path);
  void isTaking(bool isTaking);
  void onChangeGerente(String gerente);
  void onChangeTelefonoContacto(String telefonoContacto);
}
