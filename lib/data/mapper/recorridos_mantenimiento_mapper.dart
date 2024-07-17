import 'package:form_without_internet/app/extensions.dart';
import 'package:form_without_internet/data/responses/recorrido_mantenimiento_response.dart/recorridos_mantenimiento_response.dart';
import 'package:form_without_internet/domain/models/recorridos_mantenimiento_response_model/recorridos_mantenimiento_response_model.dart';

extension RecorridosMantenimientoApiMapper on RecorridoSucursal {
  RecorridoSucursalModel toDomain() {
    return RecorridoSucursalModel(
      checklist: checklist.orPendingSucursal(),
      folio: folio.orEmpty(),
      nombre: nombre.orEmpty(),
      region: region.orEmpty(),
      tipo: tipo.orEmpty(),
    );
  }
}

extension RecorridosMantenimientoDataMapper on RecorridosMantenimientoData {
  RecorridosMantenimientoResponseModelData toDomain() {
    return RecorridosMantenimientoResponseModelData(
      sem: sem.orZero(),
      inicio: inicio.orEmpty(),
      fin: fin.orEmpty(),
      fechaRegistro: fechaRegistro.orEmpty(),
      responsable: responsable.orEmpty(),
      status: status.orPending(),
      recorridoSucursalModels: recorridoSucursales?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension RecorridosMantenimientoMapper on RecorridosMantenimientoResponse {
  RecorridosMantenimientoResponseModel toDomain() {
    return RecorridosMantenimientoResponseModel(
      data: data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}
