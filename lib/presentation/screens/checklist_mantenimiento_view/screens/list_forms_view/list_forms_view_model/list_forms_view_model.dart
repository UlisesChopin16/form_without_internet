import 'package:form_without_internet/app/dep_inject.dart';
import 'package:form_without_internet/domain/models/list_forms_response_model/list_forms_response_model.dart';
import 'package:form_without_internet/domain/usecases/list_forms_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_forms_view_model.freezed.dart';
part 'list_forms_view_model.g.dart';

@freezed
class ListFormsModel with _$ListFormsModel {
  const factory ListFormsModel({
    @Default(false) bool isLoading,
    @Default('') String listOf,
    @Default([]) List<SectionResponseModel> data,
  }) = _ListFormsModel;
}

@riverpod
class ListFormsViewModel extends _$ListFormsViewModel implements ListFormsInput {
  final ListFormsUseCase _useCase = instance<ListFormsUseCase>();

  @override
  ListFormsModel build() {
    return const ListFormsModel();
  }

  @override
  void getForms(String section) async {
    state = state.copyWith(isLoading: true);

    final data = await _useCase.execute(section);

    state = state.copyWith(
      data: data.data!,
      isLoading: false,
    );
  }

  @override
  void changeState(bool value, int index) {
    List<SectionResponseModel> newData = List.from(state.data);
    newData[index] = newData[index].copyWith(active: value);
    state = state.copyWith(data: newData);
  }
}

abstract class ListFormsInput {
  void getForms(String section);
  void changeState(bool value, int index);
}
