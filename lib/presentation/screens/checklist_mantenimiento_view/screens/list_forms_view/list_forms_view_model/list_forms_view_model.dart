import 'package:form_without_internet/app/dep_inject.dart';
import 'package:form_without_internet/domain/models/list_forms_response_model/list_forms_response_model.dart';
import 'package:form_without_internet/domain/usecases/list_forms_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_forms_view_model.freezed.dart';
part 'list_forms_view_model.g.dart';

@freezed
class ListFormsModel with _$ListFormsModel {
  const ListFormsModel._();
  const factory ListFormsModel({
    @Default('') String folio,
    @Default(false) bool isLoading,
    @Default('') String listOf,
    @Default([]) List<SectionResponseModel> data,
  }) = _ListFormsModel;

  ListFormsResponseModel toSent() {
    return ListFormsResponseModel(
      data: data,
    );
  }
}

@riverpod
class ListFormsViewModel extends _$ListFormsViewModel implements ListFormsInput {
  final ListFormsUseCase _useCase = instance<ListFormsUseCase>();

  @override
  ListFormsModel build() {
    return const ListFormsModel();
  }

  @override
  void getForms(List<String> contain) async {
    state = state.copyWith(
      isLoading: true,
      listOf: contain[0],
      folio: contain[1],
    );
    final data = await _useCase.execute(contain);

    // organizar la lista por active y title
    final List<SectionResponseModel> dataSource = List.from(data.data!);
    dataSource.sort((a, b) {
      if (a.active == b.active) {
        return a.title.compareTo(b.title);
      }
      return a.active ? -1 : 1;
    });

    state = state.copyWith(
      data: dataSource,
      isLoading: false,
    );
  }

  @override
  void sendForms() async {
    final data = state.toSent();
    await _useCase.sendForm(
      body: data,
      section: state.listOf,
      folio: state.folio,
    );
  }

  @override
  void changeState(bool value, int index) async {
    List<SectionResponseModel> newData = List.from(state.data);
    newData[index] = newData[index].copyWith(active: value);
    // organizar la lista por active y title
    newData.sort((a, b) {
      if (a.active == b.active) {
        return a.title.compareTo(b.title);
      }
      return a.active ? -1 : 1;
    });
    state = state.copyWith(data: newData);

    sendForms();
  }

  @override
  List<int> getCompletedsAndNot(int index) {
    List<int> completedsAndNot = [];
    int completeds = 0;
    int notCompleteds = 0;

    for (var element in state.data[index].questionsResponseModel) {
      if (element.value.isNotEmpty) {
        completeds++;
      } else {
        notCompleteds++;
      }
    }

    completedsAndNot.add(completeds);
    completedsAndNot.add(notCompleteds);
    return completedsAndNot;
  }

  @override
  void getQuestions(List<QuestionsResponseModel> questions, int index) {
    state = state.copyWith(
      isLoading: true,
    );
    List<SectionResponseModel> newData = List.from(state.data);
    newData[index] = newData[index].copyWith(questionsResponseModel: questions);
    state = state.copyWith(data: newData, isLoading: false);

    sendForms();
  }

  putInloading() {
    state = state.copyWith(isLoading: true);
  }
}

abstract class ListFormsInput {
  void sendForms();
  void getForms(List<String> data);
  void changeState(bool value, int index);
  void getQuestions(List<QuestionsResponseModel> questions, int index);
  List<int> getCompletedsAndNot(int index);
}
