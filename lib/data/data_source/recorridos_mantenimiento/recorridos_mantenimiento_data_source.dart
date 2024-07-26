import 'dart:io';

import 'package:form_without_internet/data/responses/list_form_response/list_forms_response.dart';
import 'package:form_without_internet/data/responses/recorrido_mantenimiento_response.dart/recorridos_mantenimiento_response.dart';
import 'package:form_without_internet/domain/models/list_forms_response_model/list_forms_response_model.dart';

abstract class RecorridosMantenimientoDataSource {
  Future<RecorridosMantenimientoResponse> getRecorridosMantenimientoDS();
  Future<ListFormsResponse> getListFormsDS();
  Future<void> sendFormDS(ListFormsResponseModel body);
  Future<File> getPlanoSucursalDS();
}
