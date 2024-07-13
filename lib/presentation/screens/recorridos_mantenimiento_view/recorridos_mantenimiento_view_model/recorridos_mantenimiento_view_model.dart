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

  Map<String,dynamic> cantidades(List<RecorridoSucursalModel> recorridosSucursal) {
    final List<List<RecorridoSucursalModel>> recorridos = [];
    final List<RecorridoSucursalModel> pendientesL = [];
    final List<RecorridoSucursalModel> enCursoL = [];
    final List<RecorridoSucursalModel> finalizadosL = [];
    final List<int> cantidades = [];
    int totales = recorridosSucursal.length;
    int pendientes = 0;
    int enCurso = 0;
    int finalizados = 0;

    for (var recorrido in recorridosSucursal) {
      if (recorrido.checklist == 'Pendiente') {
        pendientes++;
        pendientesL.add(recorrido);
      } else if (recorrido.checklist == 'En curso') {
        enCurso++;
        enCursoL.add(recorrido);
      } else if (recorrido.checklist == 'Completado') {
        finalizados++;
        finalizadosL.add(recorrido);
      }
    }
    
    recorridos.add(pendientesL);
    recorridos.add(enCursoL);
    recorridos.add(finalizadosL);

    cantidades.add(totales);
    cantidades.add(pendientes);
    cantidades.add(enCurso);
    cantidades.add(finalizados);



    return {
      'recorridos': recorridos,
      'cantidades': cantidades,
    };
  
  }
}

abstract class RecorridosMantenimientoInput {
  void getRecorridosMantenimiento();
}
