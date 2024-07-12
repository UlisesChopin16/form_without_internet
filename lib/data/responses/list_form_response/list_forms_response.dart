import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_forms_response.freezed.dart';
part 'list_forms_response.g.dart';

@freezed
class ListFormsResponse with _$ListFormsResponse {
  const ListFormsResponse._();

  const factory ListFormsResponse({
    @JsonKey(name: 'data') List<Section>? data,
  }) = _ListFormsResponse;

  factory ListFormsResponse.fromJson(Map<String, dynamic> json) => _$ListFormsResponseFromJson(json);

  String toEncoded() {
    return json.encode(
      ListFormsResponse(
        data: data,
      ).toJson(),
    );
  }
}

@freezed
class Section with _$Section {
  const factory Section({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'active') bool? active,
    @JsonKey(name: 'questions') List<Questions>? questions,
  }) = _Section;

  factory Section.fromJson(Map<String, dynamic> json) => _$SectionFromJson(json);
}

@freezed
class Questions with _$Questions {
  const factory Questions({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'value') String? value,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'images') List<String>? images,
  }) = _Questions;

  factory Questions.fromJson(Map<String, dynamic> json) => _$QuestionsFromJson(json);
}
