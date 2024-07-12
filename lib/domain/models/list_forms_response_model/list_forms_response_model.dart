import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_forms_response_model.freezed.dart';
part 'list_forms_response_model.g.dart';

@freezed
class ListFormsResponseModel with _$ListFormsResponseModel {
  const ListFormsResponseModel._();
  const factory ListFormsResponseModel({
    @JsonKey(name: 'data')
    required List<SectionResponseModel>? data,
  }) = _ListFormsResponseModel;

  factory ListFormsResponseModel.fromJson(Map<String, dynamic> json) => _$ListFormsResponseModelFromJson(json);

  String toEncoded() {
    return json.encode(
      ListFormsResponseModel(
        data: data,
      ).toJson(),
    );
  }
}

@freezed
class SectionResponseModel with _$SectionResponseModel {
  const factory SectionResponseModel({
    @JsonKey(name: 'id')
    required String id,
    @JsonKey(name: 'title')
    required String title,
    @JsonKey(name: 'active')
    required bool active,
    @JsonKey(name: 'questions')
     required List<QuestionsResponseModel> questionsResponseModel,
  }) = _SectionResponseModel;

  factory SectionResponseModel.fromJson(Map<String, dynamic> json) => _$SectionResponseModelFromJson(json);
}

@freezed
class QuestionsResponseModel with _$QuestionsResponseModel {
  const factory QuestionsResponseModel({
    @JsonKey(name: 'id')
    required String id,
    @JsonKey(name: 'name')
    required String name,
    @JsonKey(name: 'value')
    required String value,
    @JsonKey(name: 'description')
    required String description,
    @JsonKey(name: 'images')
    required List<String> images,
  }) = _QuestionsResponseModel;

  factory QuestionsResponseModel.fromJson(Map<String, dynamic> json) => _$QuestionsResponseModelFromJson(json);
}