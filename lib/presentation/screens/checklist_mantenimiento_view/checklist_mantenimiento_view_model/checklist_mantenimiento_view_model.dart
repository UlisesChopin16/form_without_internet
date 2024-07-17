import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'checklist_mantenimiento_view_model.freezed.dart';
part 'checklist_mantenimiento_view_model.g.dart';

@freezed
class ChecklistMantenimientoModel with _$ChecklistMantenimientoModel {
  const factory ChecklistMantenimientoModel({
    // Add attributes here
    @Default(0) int currentTabIndex,
    @Default(0) int currentResumeTabIndex,
    @Default([]) List<String> tabs,
  }) = _ChecklistMantenimientoModel;

  static const List<String> tabsName = [
    'Fachada',
    'Áreas',
    'Sanitarios',
    'Servicios',
    'Misceláneo',
  ];
}


@riverpod
class ChecklistMantenimientoViewModel extends _$ChecklistMantenimientoViewModel {

  @override 
  ChecklistMantenimientoModel build() {
    return const ChecklistMantenimientoModel(
      tabs: ChecklistMantenimientoModel.tabsName,
    );
  }

  void changeTabIndex(int index) {
    state = state.copyWith(currentTabIndex: index);
  }

  void changeResumeTabIndex(int index) {
    state = state.copyWith(currentResumeTabIndex: index);
  }

}