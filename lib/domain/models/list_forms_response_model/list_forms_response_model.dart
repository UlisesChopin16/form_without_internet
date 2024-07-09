import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_forms_response_model.freezed.dart';
part 'list_forms_response_model.g.dart';

@freezed
class ListFormsResponseModel with _$ListFormsResponseModel {
  const factory ListFormsResponseModel({
    required List<SectionResponseModel>? data,
  }) = _ListFormsResponseModel;

  factory ListFormsResponseModel.fromJson(Map<String, dynamic> json) => _$ListFormsResponseModelFromJson(json);
}

@freezed
class SectionResponseModel with _$SectionResponseModel {
  const factory SectionResponseModel({
    required String id,
    required String title,
    required bool active,
    required List<QuestionsResponseModel> questionsResponseModel,
  }) = _SectionResponseModel;

  factory SectionResponseModel.fromJson(Map<String, dynamic> json) => _$SectionResponseModelFromJson(json);
}

@freezed
class QuestionsResponseModel with _$QuestionsResponseModel {
  const factory QuestionsResponseModel({
    required String id,
    required String name,
    required String value,
    required String description,
    required List<String> images,
  }) = _QuestionsResponseModel;

  factory QuestionsResponseModel.fromJson(Map<String, dynamic> json) => _$QuestionsResponseModelFromJson(json);
}