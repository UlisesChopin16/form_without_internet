import 'package:form_without_internet/domain/models/list_forms_response_model/list_forms_response_model.dart';
import 'package:form_without_internet/domain/models/recorridos_mantenimiento_response_model/recorridos_mantenimiento_response_model.dart';

abstract class RecorridosMantenimientoRepository {
  Future<RecorridosMantenimientoResponseModel> getRecorridosMantenimientoRep();
  Future<ListFormsResponseModel> getListFormsRep(String section, String folio);
  Future<void> sendFormRep(
      {required ListFormsResponseModel body, required String section, required String folio});
}
