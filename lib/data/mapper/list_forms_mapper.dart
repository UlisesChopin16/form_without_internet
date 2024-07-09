import 'package:form_without_internet/app/extensions.dart';
import 'package:form_without_internet/data/responses/list_form_response/list_forms_response.dart';
import 'package:form_without_internet/domain/models/list_forms_response_model/list_forms_response_model.dart';

extension ListFormsMapper on ListFormsResponse {
  ListFormsResponseModel toDomain() {
    return ListFormsResponseModel(
      data: data?.map((e) => e.toDomain()).toList(),
    );
  }
}

extension SectionMapper on Section {
  SectionResponseModel toDomain() {
    return SectionResponseModel(
      id: id.orEmpty(),
      title: title.orEmpty(),
      active: active ?? false,
      questionsResponseModel: questions?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension QuestionsMapper on Questions {
  QuestionsResponseModel toDomain() {
    return QuestionsResponseModel(
      id: id.orEmpty(),
      name: name.orEmpty(),
      value: value.orEmpty(),
      description: description.orEmpty(),
      images: images ?? [],
    );
  }
}
