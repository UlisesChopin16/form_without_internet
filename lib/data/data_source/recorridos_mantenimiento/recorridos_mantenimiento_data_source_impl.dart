import 'package:form_without_internet/data/data_source/recorridos_mantenimiento/recorridos_mantenimiento_data_source.dart';
import 'package:form_without_internet/data/network/apis/recorridos_mantenimiento_api.dart';
import 'package:form_without_internet/data/responses/recorrido_mantenimiento_response.dart/recorridos_mantenimiento_response.dart';

class RecorridosMantenimientoDataSourceImpl implements RecorridosMantenimientoDataSource {
  final RecorridosMantenimientoApi recorridosMantenimientoApi;

  RecorridosMantenimientoDataSourceImpl({required this.recorridosMantenimientoApi});

  @override
  Future<RecorridosMantenimientoResponse> getRecorridosMantenimientoDS() {
    final response = recorridosMantenimientoApi.getRecorridosMantenimiento();
    return response;
  }
}
