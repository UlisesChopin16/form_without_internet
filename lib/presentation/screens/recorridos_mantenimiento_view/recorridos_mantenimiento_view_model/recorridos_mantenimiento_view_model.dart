import 'package:form_without_internet/app/dep_inject.dart';
import 'package:form_without_internet/domain/models/recorridos_mantenimiento_response_model/recorridos_mantenimiento_response_model.dart';
import 'package:form_without_internet/domain/usecases/recorridos_mantenimiento_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recorridos_mantenimiento_view_model.freezed.dart';
part 'recorridos_mantenimiento_view_model.g.dart';

@freezed
class RecorridosMantenimientoModel with _$RecorridosMantenimientoModel {
  const factory RecorridosMantenimientoModel({
    @Default([]) List<RecorridosMantenimientoResponseModelData> data,
    @Default(false) bool isLoading,
  }) = _RecorridosMantenimientoModel;
}

@riverpod
class RecorridosMantenimientoViewModel extends _$RecorridosMantenimientoViewModel
    implements RecorridosMantenimientoInput {
  final RecorridosMantenimientoUseCase _useCase = instance<RecorridosMantenimientoUseCase>();

  @override
  RecorridosMantenimientoModel build() {
    return const RecorridosMantenimientoModel();
  }

  @override
  void getRecorridosMantenimiento() async {
    state = state.copyWith(isLoading: true);

    final data = await _useCase.execute(null);

    state = state.copyWith(data: data.data, isLoading: false);
  }
}

abstract class RecorridosMantenimientoInput {
  void getRecorridosMantenimiento();
}
