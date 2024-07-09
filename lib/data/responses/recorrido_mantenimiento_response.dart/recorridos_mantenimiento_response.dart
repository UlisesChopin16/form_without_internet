import 'package:freezed_annotation/freezed_annotation.dart';

part 'recorridos_mantenimiento_response.freezed.dart';
part 'recorridos_mantenimiento_response.g.dart';

@freezed
class RecorridosMantenimientoResponse with _$RecorridosMantenimientoResponse {
  const factory RecorridosMantenimientoResponse({
    @JsonKey(name: 'data') List<RecorridosMantenimientoData>? data,
  }) = _RecorridosMantenimientoResponse;

  factory RecorridosMantenimientoResponse.fromJson(Map<String, dynamic> json) =>
      _$RecorridosMantenimientoResponseFromJson(json);
}

@freezed
class RecorridosMantenimientoData with _$RecorridosMantenimientoData {
  const factory RecorridosMantenimientoData({
    @JsonKey(name: 'sem') int? sem,
    @JsonKey(name: 'inicio') String? inicio,
    @JsonKey(name: 'fin') String? fin,
    @JsonKey(name: 'responsable') String? responsable,
    @JsonKey(name: 'recorrido_sucursales') List<RecorridoSucursal>? recorridoSucursales,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'fecha_registro') String? fechaRegistro,
  }) = _RecorridosMantenimientoData;

  factory RecorridosMantenimientoData.fromJson(Map<String, dynamic> json) =>
      _$RecorridosMantenimientoDataFromJson(json);
}

@freezed
class RecorridoSucursal with _$RecorridoSucursal {
  const factory RecorridoSucursal({
    @JsonKey(name: 'folio') String? folio,
    @JsonKey(name: 'nombre') String? nombre,
    @JsonKey(name: 'tipo') String? tipo,
    @JsonKey(name: 'region') String? region,
    @JsonKey(name: 'checklist') String? checklist,
  }) = _RecorridoSucursal;

  factory RecorridoSucursal.fromJson(Map<String, dynamic> json) =>
      _$RecorridoSucursalFromJson(json);
}
