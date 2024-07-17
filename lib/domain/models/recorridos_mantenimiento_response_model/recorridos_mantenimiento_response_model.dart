import 'package:form_without_internet/types/status_recorrido_mantenimiento_type.dart';
import 'package:form_without_internet/types/status_recorrido_sucursal_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recorridos_mantenimiento_response_model.freezed.dart';
part 'recorridos_mantenimiento_response_model.g.dart';

@freezed
class RecorridosMantenimientoResponseModel with _$RecorridosMantenimientoResponseModel {
  const factory RecorridosMantenimientoResponseModel({
    required List<RecorridosMantenimientoResponseModelData> data,
  }) = _RecorridosMantenimientoResponseModel;

  factory RecorridosMantenimientoResponseModel.fromJson(Map<String, dynamic> json) => _$RecorridosMantenimientoResponseModelFromJson(json);
}

@freezed
class RecorridosMantenimientoResponseModelData with _$RecorridosMantenimientoResponseModelData {
  const factory RecorridosMantenimientoResponseModelData({
    required int sem,
    required String inicio,
    required String fin,
    required String responsable,
    required List<RecorridoSucursalModel> recorridoSucursalModels,
    required StatusRecorridoMantenimientoType status,
    required String fechaRegistro,
  }) = _RecorridoMantenimientoResponseModel;

  factory RecorridosMantenimientoResponseModelData.fromJson(Map<String, dynamic> json) =>
      _$RecorridosMantenimientoResponseModelDataFromJson(json);
}

@freezed
class RecorridoSucursalModel with _$RecorridoSucursalModel {
  const factory RecorridoSucursalModel({
    required String folio,
    required String nombre,
    required String tipo,
    required String region,
    required StatusRecorridoSucursalType checklist,
  }) = _RecorridoSucursalModel;

  factory RecorridoSucursalModel.fromJson(Map<String, dynamic> json) =>
      _$RecorridoSucursalModelFromJson(json);
}
