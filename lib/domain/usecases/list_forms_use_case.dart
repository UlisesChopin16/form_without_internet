import 'package:form_without_internet/data/repository/recorridos_mantenimiento_repository.dart';
import 'package:form_without_internet/domain/models/list_forms_response_model/list_forms_response_model.dart';
import 'package:form_without_internet/domain/usecases/base_use_case.dart';

class ListFormsUseCase implements BaseUseCase<List<String>, ListFormsResponseModel> {
  final RecorridosMantenimientoRepository repository;

  const ListFormsUseCase(this.repository);
  // this is the function that will be called from the UI
  @override
  Future<ListFormsResponseModel> execute(List<String> data) async {
    // first we get the device info
    final section = data[0];
    final folio = data[1];

    // then we call the repository to login the customer
    final response = await repository.getListFormsRep(section, folio);

    return response;
  }

  Future<void> sendForm(
      {required ListFormsResponseModel body,
      required String section,
      required String folio}) async {
    await repository.sendFormRep(
      body: body,
      section: section,
      folio: folio,
    );
  }
}
