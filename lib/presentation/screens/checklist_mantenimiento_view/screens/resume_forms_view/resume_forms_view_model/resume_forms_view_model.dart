import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resume_forms_view_model.freezed.dart';
part 'resume_forms_view_model.g.dart';

@freezed
class ResumeFormsModel with _$ResumeFormsModel {
  const factory ResumeFormsModel({
    @Default([]) List<bool> listExpandeds,
  }) = _ResumeFormsModel;
}


@riverpod
class ResumeFormsViewModel extends _$ResumeFormsViewModel {

  @override
  ResumeFormsModel build() {
    return const ResumeFormsModel();
  }

  void generateListExpandeds(int length) {
    final List<bool> listExpandeds = [];
    for (var i = 0; i < length; i++) {
      listExpandeds.add(true);
    }
    state = state.copyWith(listExpandeds: listExpandeds);
  }

  void changeExpanded(int index) {
    final List<bool> listExpandeds = List.from(state.listExpandeds);
    listExpandeds[index] = !listExpandeds[index];
    state = state.copyWith(listExpandeds: listExpandeds);
  }

  // meotod para contraer todos los elementos
  void compressAll(bool value) {
    final List<bool> listExpandeds = [];
    for (var i = 0; i < state.listExpandeds.length; i++) {
      listExpandeds.add(value);
    }
    state = state.copyWith(listExpandeds: listExpandeds);
  }

}