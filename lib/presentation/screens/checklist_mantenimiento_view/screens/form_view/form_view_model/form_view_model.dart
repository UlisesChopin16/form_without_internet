import 'package:form_without_internet/domain/models/list_forms_response_model/list_forms_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_view_model.freezed.dart';
part 'form_view_model.g.dart';

@freezed
class FormModel with _$FormModel {
  const factory FormModel({
    @Default('') String title,
    @Default([]) List<QuestionsResponseModel> questions,
    @Default([]) List<bool> isExpanded,
  }) = _FormModel;
}

@riverpod
class FormViewModel extends _$FormViewModel {
  @override
  FormModel build() {
    return const FormModel();
  }

  getQuestions(List<QuestionsResponseModel> questions, String title) {
    late List<bool> isExpanded = List.generate(
      questions.length,
      (index) => false,
    );
    state = state.copyWith(
      questions: questions,
      title: title,
      isExpanded: isExpanded,
    );
  }

  changeSize(int index) {
    List<bool> newIsExpanded = List.from(state.isExpanded);
    newIsExpanded[index] = true;
    state = state.copyWith(isExpanded: newIsExpanded);
  }

  addImage(int index, String imagePath) {
    List<String> images = List.from(state.questions[index].images);
    images.add(imagePath);
    List<QuestionsResponseModel> newQuestionsResponse = List.from(state.questions);
    newQuestionsResponse[index] = newQuestionsResponse[index].copyWith(images: images);
    state = state.copyWith(questions: newQuestionsResponse);
  }

  deleteImage(int indexItem, int indexImage) {
    List<String> images = List.from(state.questions[indexItem].images);
    images.removeAt(indexImage);
    List<QuestionsResponseModel> newQuestionsResponse = List.from(state.questions);
    newQuestionsResponse[indexItem] = newQuestionsResponse[indexItem].copyWith(images: images);
    state = state.copyWith(questions: newQuestionsResponse);
  }

  changeValue(int indexItem, String value) {
    List<QuestionsResponseModel> newQuestionsResponse = List.from(state.questions);
    newQuestionsResponse[indexItem] = newQuestionsResponse[indexItem].copyWith(value: value);
    state = state.copyWith(questions: newQuestionsResponse);
  }
}
