import 'package:form_without_internet/domain/models/recorridos_mantenimiento_response_model.dart';

abstract class RecorridosMantenimientoRepository {
  Future<RecorridosMantenimientoResponseModel> getRecorridosMantenimientoRep();
}
