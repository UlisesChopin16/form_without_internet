import 'package:form_without_internet/types/status_recorrido_mantenimiento_type.dart';
import 'package:form_without_internet/types/status_recorrido_sucursal_type.dart';
import 'package:form_without_internet/types/tipo_sucursal_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filtros_model.freezed.dart';
part 'filtros_model.g.dart';

class FiltrosModelRecorridosMantenimiento {
  final StatusRecorridoMantenimientoType? filterStatusMant;

  const FiltrosModelRecorridosMantenimiento({
    required this.filterStatusMant,
  });
}

// class FiltrosModelRecorridosSucursales {
//   final StatusRecorridoSucursalType? filterStatusSucursal;
//   final String? tipoSucursal;
//   final String? region;
//   final String? cAnalitico;
//   final String? oficina;

//   const FiltrosModelRecorridosSucursales({
//     this.filterStatusSucursal,
//     this.tipoSucursal,
//     this.region,
//     this.cAnalitico,
//     this.oficina,
//   });
// }

@freezed
class FiltrosModelRecorridosSucursales with _$FiltrosModelRecorridosSucursales {
  const factory FiltrosModelRecorridosSucursales({
    @Default(false) bool hasFilters,
    @Default(StatusRecorridoSucursalType.todos) StatusRecorridoSucursalType filterStatusSucursal,
    TipoSucursalType? tipoSucursal,
    String? region,
    String? cAnalitico,
    String? oficina,
    String? sucursal,
  }) = _FiltrosModelRecorridosSucursales;

  factory FiltrosModelRecorridosSucursales.fromJson(Map<String, dynamic> json) =>
      _$FiltrosModelRecorridosSucursalesFromJson(json);
}
