import 'package:form_without_internet/data/data_source/recorridos_mantenimiento/recorridos_mantenimiento_data_source.dart';
import 'package:form_without_internet/data/network/apis/recorridos_mantenimiento_api.dart';
import 'package:form_without_internet/data/responses/list_form_response/list_forms_response.dart';
import 'package:form_without_internet/data/responses/recorrido_mantenimiento_response.dart/recorridos_mantenimiento_response.dart';
import 'package:form_without_internet/domain/models/list_forms_response_model/list_forms_response_model.dart';

class RecorridosMantenimientoDataSourceImpl implements RecorridosMantenimientoDataSource {
  final RecorridosMantenimientoApi recorridosMantenimientoApi;

  RecorridosMantenimientoDataSourceImpl({required this.recorridosMantenimientoApi});

  @override
  Future<RecorridosMantenimientoResponse> getRecorridosMantenimientoDS() async {
    final response = await recorridosMantenimientoApi.getRecorridosMantenimiento();
    return response;
  }

  @override
  Future<ListFormsResponse> getListFormsDS() async {
    final response = await recorridosMantenimientoApi.getListForms();
    return response;
  }
  
  @override
  Future<void> sendFormDS(ListFormsResponseModel body) async {
    return await recorridosMantenimientoApi.sendForm(body.toJson());
  }
}
