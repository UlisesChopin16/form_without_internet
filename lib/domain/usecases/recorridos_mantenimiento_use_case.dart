import 'package:form_without_internet/data/repository/recorridos_mantenimiento_repository.dart';
import 'package:form_without_internet/domain/models/recorridos_mantenimiento_response_model/recorridos_mantenimiento_response_model.dart';
import 'package:form_without_internet/domain/usecases/base_use_case.dart';

class RecorridosMantenimientoUseCase
    implements BaseUseCase<void, RecorridosMantenimientoResponseModel> {
  final RecorridosMantenimientoRepository repository;

  const RecorridosMantenimientoUseCase(this.repository);
  // this is the function that will be called from the UI
  @override
  Future<RecorridosMantenimientoResponseModel> execute(void data) async {
    // first we get the device info

    // then we call the repository to login the customer
    final response = await repository.getRecorridosMantenimientoRep();

    return response;
  }
}
