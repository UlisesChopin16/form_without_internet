import 'package:form_without_internet/data/responses/recorrido_mantenimiento_response.dart/recorridos_mantenimiento_response.dart';

abstract class RecorridosMantenimientoDataSource {
  Future<RecorridosMantenimientoResponse> getRecorridosMantenimientoDS();
}
