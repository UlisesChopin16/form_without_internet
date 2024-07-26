import 'dart:async';
import 'dart:io';

import 'package:form_without_internet/app/dep_inject.dart';
import 'package:form_without_internet/domain/models/recorridos_mantenimiento_response_model/recorridos_mantenimiento_response_model.dart';
import 'package:form_without_internet/domain/usecases/recorridos_mantenimiento_use_case.dart';
import 'package:form_without_internet/types/status_recorrido_sucursal_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recorridos_mantenimiento_view_model.freezed.dart';
part 'recorridos_mantenimiento_view_model.g.dart';

@freezed
class RecorridosMantenimientoModel with _$RecorridosMantenimientoModel {
  const factory RecorridosMantenimientoModel({
    @Default([]) List<RecorridosMantenimientoResponseModelData> data,
    @Default(false) bool isLoading,
    @Default([]) List<RecorridoSucursalModel> recorridosFiltrados,
    @Default([]) List<RecorridoSucursalModel> recorridos,
    @Default('') String filter,
    @Default(false) bool isFiltered,
  }) = _RecorridosMantenimientoModel;
}

@riverpod
class RecorridosMantenimientoViewModel extends _$RecorridosMantenimientoViewModel
    implements RecorridosMantenimientoInput {
  Timer? _timer;
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

  Future<File> getPlanoSucursal(String folio) async {
    final response = await _useCase.getPlanoSucursal(folio);
    print(response);
    return response;
  }

  bool trueOrFalse(int index) {
    return index % 2 == 0;
  }

  ({
    List<List<RecorridoSucursalModel>> cantidadRecorridos,
    List<int> numeroCantidades,
  }) cantidades(List<RecorridoSucursalModel> recorridosSucursal) {
    final List<List<RecorridoSucursalModel>> recorridosS = [];
    final List<RecorridoSucursalModel> pendientesL = [];
    final List<RecorridoSucursalModel> enCursoL = [];
    final List<RecorridoSucursalModel> finalizadosL = [];
    final List<int> cantidadesS = [];
    int pendientes = 0;
    int enCurso = 0;
    int finalizados = 0;
    int totales = recorridosSucursal.length;

    for (var recorrido in recorridosSucursal) {
      if (recorrido.checklist == StatusRecorridoSucursalType.pendiente) {
        pendientes++;
        pendientesL.add(recorrido);
      } else if (recorrido.checklist == StatusRecorridoSucursalType.enCurso) {
        enCurso++;
        enCursoL.add(recorrido);
      } else if (recorrido.checklist == StatusRecorridoSucursalType.completado) {
        finalizados++;
        finalizadosL.add(recorrido);
      }
    }

    recorridosS.add(pendientesL);
    recorridosS.add(enCursoL);
    recorridosS.add(finalizadosL);
    recorridosS.add(recorridosSucursal);

    cantidadesS.add(pendientes);
    cantidadesS.add(enCurso);
    cantidadesS.add(finalizados);
    cantidadesS.add(totales);

    return (
      cantidadRecorridos: recorridosS,
      numeroCantidades: cantidadesS,
    );
  }

  List<RecorridoSucursalModel> getAllSucursales() {
    final List<RecorridoSucursalModel> listRecorridos = [];
    final data = state.data;

    for (var recorrido in data) {
      listRecorridos.addAll(recorrido.recorridoSucursalModels);
    }
    return listRecorridos;
  }

  getListFiltered(List<RecorridoSucursalModel> recorridos) {
    state = state.copyWith(
      recorridosFiltrados: recorridos,
      recorridos: recorridos,
    );
  }

  cleanListFiltered() {
    state = state.copyWith(
      recorridos: [],
      recorridosFiltrados: [],
      filter: '',
    );
  }

  filterList(String filter) {
    _timer?.cancel();

    state = state.copyWith(filter: filter);

    if (filter.trim().isEmpty) {
      state = state.copyWith(
        isFiltered: false,
        recorridosFiltrados: [...state.recorridos],
      );
      return;
    }

    state = state.copyWith(isFiltered: true);

    _timer = Timer(const Duration(milliseconds: 500), () {
      // obtenemos los recorridos actuales
      final recorridos = state.recorridos;

      // filtramos los recorridos por folio y nombre
      final recorridosFiltrados = recorridos.where((recorrido) {
        return recorrido.folio.toLowerCase().contains(filter.toLowerCase()) ||
            recorrido.nombre.toLowerCase().contains(filter.toLowerCase()) ||
            recorrido.checklist.value.toLowerCase().contains(filter.toLowerCase()) ||
            recorrido.region.toLowerCase().contains(filter.toLowerCase()) ||
            recorrido.tipo.toLowerCase().contains(filter.toLowerCase());
      }).toList();

      // actualizamos la lista de recorridos filtrados
      state = state.copyWith(
        recorridosFiltrados: [...recorridosFiltrados],
        isFiltered: false,
      );

      // limpiamos el timer
      _timer?.cancel();
    });
  }
}

abstract class RecorridosMantenimientoInput {
  void getRecorridosMantenimiento();
}
