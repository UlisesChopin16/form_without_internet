
import 'package:form_without_internet/data/repository/recorridos_mantenimiento_repository.dart';
import 'package:form_without_internet/domain/models/list_forms_response_model/list_forms_response_model.dart';
import 'package:form_without_internet/domain/usecases/base_use_case.dart';

class ListFormsUseCase implements BaseUseCase<String, ListFormsResponseModel> {
  final RecorridosMantenimientoRepository repository;

  const ListFormsUseCase(this.repository);
  // this is the function that will be called from the UI
  @override
  Future<ListFormsResponseModel> execute(String data) async {
    // first we get the device info

    // then we call the repository to login the customer
    final response = await repository.getListFormsRep();

    return response;
  }
}