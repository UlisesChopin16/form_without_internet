import 'dart:async';

import 'package:form_without_internet/domain/models/list_forms_response_model/list_forms_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_view_model.freezed.dart';
part 'form_view_model.g.dart';

@freezed
class FormModel with _$FormModel {
  const factory FormModel({
    @Default(0) int formIndex,
    @Default('') String title,
    @Default(false) bool isSaving,
    @Default(false) bool isSaved,
    @Default([]) List<QuestionsResponseModel> questions,
    @Default([]) List<bool> isExpanded,
  }) = _FormModel;
}

@riverpod
class FormViewModel extends _$FormViewModel implements FormInput {
  Timer? _timer;
  Timer? _timerSave;

  @override
  FormModel build() {
    return const FormModel();
  }

  @override
  getQuestions(List<QuestionsResponseModel> questions, String title, int index) {
    late List<bool> isExpanded = List.generate(
      questions.length,
      (index) {
        if (questions[index].value.isNotEmpty && questions[index].value != 'No aplica') {
          return true;
        }
        return false;
      },
    );
    state = state.copyWith(
      questions: questions,
      title: title,
      isExpanded: isExpanded,
      formIndex: index,
    );
  }

  @override
  void changeSize(int index) {
    List<bool> newIsExpanded = List.from(state.isExpanded);
    if (state.questions[index].value == 'No aplica') {
      newIsExpanded[index] = false;
    } else {
      newIsExpanded[index] = true;
    }
    state = state.copyWith(isExpanded: newIsExpanded);
  }

  @override
  List<QuestionsResponseModel> addImages(int index, List<String> images) {
    List<QuestionsResponseModel> newQuestionsResponse = List.from(state.questions);
    newQuestionsResponse[index] = newQuestionsResponse[index].copyWith(images: images);
    state = state.copyWith(questions: newQuestionsResponse);
    return newQuestionsResponse;
  }

  @override
  void deleteImage(int indexItem, int indexImage,
      {required void Function(List<QuestionsResponseModel>) onDelete}) async {
    putInSaving();
    List<String> images = List.from(state.questions[indexItem].images);
    images.removeAt(indexImage);
    List<QuestionsResponseModel> newQuestionsResponse = List.from(state.questions);
    newQuestionsResponse[indexItem] = newQuestionsResponse[indexItem].copyWith(images: images);
    state = state.copyWith(questions: newQuestionsResponse);
    onDelete(newQuestionsResponse);
    putInSaved();
  }

  @override
  void changeValue(int indexItem, String value) async {
    putInSaving();
    List<QuestionsResponseModel> newQuestionsResponse = List.from(state.questions);
    newQuestionsResponse[indexItem] = newQuestionsResponse[indexItem].copyWith(value: value);

    state = state.copyWith(questions: newQuestionsResponse);
    putInSaved();
  }

  @override
  void onChangeDescription(int indexItem, String value,
      {required void Function(List<QuestionsResponseModel>) onSave}) async {
    putInSaving();
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(const Duration(seconds: 1), () async {
      _timer!.cancel();
      List<QuestionsResponseModel> newQuestionsResponse = List.from(state.questions);
      newQuestionsResponse[indexItem] =
          newQuestionsResponse[indexItem].copyWith(description: value);
      state = state.copyWith(questions: newQuestionsResponse);
      onSave(newQuestionsResponse);

      putInSaved();
    });
  }

  putInSaving() {
    _timerSave?.cancel();
    state = state.copyWith(isSaving: true, isSaved: false);
  }

  void putInSaved() {
    if (_timerSave != null) {
      _timerSave!.cancel();
    }
    state = state.copyWith(
      isSaving: false,
      isSaved: true,
    );
    // await Future.delayed(const Duration(seconds: 2));
    _timerSave = Timer(const Duration(seconds: 2), () {
      state = state.copyWith(isSaved: false);
    });
  }
}

abstract class FormInput {
  void getQuestions(List<QuestionsResponseModel> questions, String title, int index);
  void changeSize(int index);
  List<QuestionsResponseModel> addImages(int index, List<String> imagePath);
  void deleteImage(int indexItem, int indexImage,
      {required void Function(List<QuestionsResponseModel>) onDelete});
  void changeValue(int indexItem, String value);
  void onChangeDescription(int indexItem, String value,
      {required void Function(List<QuestionsResponseModel> questions) onSave});
}
