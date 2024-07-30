import 'dart:async';
import 'dart:io';

import 'package:form_without_internet/app/dep_inject.dart';
import 'package:form_without_internet/domain/models/filtros_model/filtros_model.dart';
import 'package:form_without_internet/domain/models/recorridos_mantenimiento_response_model/recorridos_mantenimiento_response_model.dart';
import 'package:form_without_internet/domain/usecases/recorridos_mantenimiento_use_case.dart';
import 'package:form_without_internet/types/status_recorrido_mantenimiento_type.dart';
import 'package:form_without_internet/types/status_recorrido_sucursal_type.dart';
import 'package:form_without_internet/types/tipo_sucursal_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recorridos_mantenimiento_view_model.freezed.dart';
part 'recorridos_mantenimiento_view_model.g.dart';

@freezed
class RecorridosMantenimientoModel with _$RecorridosMantenimientoModel {
  const factory RecorridosMantenimientoModel({
    @Default([]) List<RecorridosMantenimientoResponseModelData> data,
    @Default([]) List<RecorridosMantenimientoResponseModelData> filteredData,
    @Default([]) List<RecorridoSucursalModel> recorridosFiltrados,
    @Default([]) List<RecorridoSucursalModel> recorridos,
    // status
    @Default(null) StatusRecorridoMantenimientoType? filterStatusMant,
    @Default(FiltrosModelRecorridosSucursales()) FiltrosModelRecorridosSucursales filtersSucursales,
    @Default(false) bool isLoading,
    @Default(false) bool isFiltered,
    @Default(false) bool isFilteringM,
    @Default(false) bool expandFiltersM,
    @Default(false) bool expandFiltersS,
  }) = _RecorridosMantenimientoModel;
}

@riverpod
class RecorridosMantenimientoViewModel extends _$RecorridosMantenimientoViewModel
    implements RecorridosMantenimientoInput, FiltrosSucursalesInput {
  // timer para filtrar recorridos mantenimiento
  Timer? _filterTimer;

  // timer para filtrar recorridos sucursales
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

    state = state.copyWith(
      data: data.data,
      filteredData: data.data,
      filtersSucursales: const FiltrosModelRecorridosSucursales(),
      isLoading: false,
    );
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

  Future<File> getPlanoSucursal(String folio) async {
    final response = await _useCase.getPlanoSucursal(folio);
    print(response);
    return response;
  }


  void expandFiltersM() {
    state = state.copyWith(expandFiltersM: !state.expandFiltersM);
  }

  void expandFiltersS() {
    state = state.copyWith(expandFiltersS: !state.expandFiltersS);
  }

  // ------------------------- FILTROS RECORRIDOS MANTENIMIENTO -----------------------------------
  void filterStatusRecorridoMant(StatusRecorridoMantenimientoType? status) {
    _filterTimer?.cancel();

    state = state.copyWith(isFilteringM: true, filterStatusMant: status);

    _filterTimer = Timer(const Duration(milliseconds: 500), () {
      // obtenemos los recorridos actuales
      final recorridos = state.data;

      // filtramos los recorridos por folio y nombre
      final recorridosFiltrados = recorridos.where((recorrido) {
        return recorrido.status == status;
      }).toList();

      // actualizamos la lista de recorridos filtrados
      state = state.copyWith(
        filteredData: [...recorridosFiltrados],
        isFilteringM: false,
      );

      // limpiamos el timer
      _filterTimer?.cancel();
    });
  }

  void clearFilterStatusRecorridoMant() {
    _filterTimer?.cancel();

    state = state.copyWith(
      filterStatusMant: null,
      isFilteringM: true,
    );

    _filterTimer = Timer(const Duration(milliseconds: 500), () {
      state = state.copyWith(
        filteredData: [...state.data],
        isFilteringM: false,
      );

      _filterTimer?.cancel();
    });
  }


  // ------------------------- FILTROS SUCURSALES -----------------------------------
  getListSucursalesFiltered(List<RecorridoSucursalModel> recorridos) {
    state = state.copyWith(
      recorridosFiltrados: recorridos,
      recorridos: recorridos,
    );
  }

  cleanListSucursalesFiltered() {
    state = state.copyWith(
      recorridos: [],
      recorridosFiltrados: [],
      filtersSucursales: const FiltrosModelRecorridosSucursales(),
      isFiltered: false,
      expandFiltersS: false,
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
  
  @override
  void cleanFilters() {
    _timer?.cancel();

    state = state.copyWith(
      isFiltered: true,
    );

    _timer = Timer(const Duration(milliseconds: 500), () {
      state = state.copyWith(
        recorridosFiltrados: state.recorridos,
        isFiltered: false,
        filtersSucursales: const FiltrosModelRecorridosSucursales(),
      );
    });

    state = state.copyWith();
  }

  @override
  void cleanRegionFilter() {
    _timer?.cancel();

    state = state.copyWith(
      isFiltered: true,
      filtersSucursales: state.filtersSucursales.copyWith(region: null),
    );

    checkFilters();

    _timer = Timer(const Duration(milliseconds: 500), () {
      state = state.copyWith(
        recorridosFiltrados: state.recorridos,
        isFiltered: false,
      );
    });
  }

  @override
  void cleanStatusFilter() {
    _timer?.cancel();

    state = state.copyWith(
      isFiltered: true,
      filtersSucursales:
          state.filtersSucursales.copyWith(filterStatusSucursal: StatusRecorridoSucursalType.todos),
    );

    checkFilters();

    _timer = Timer(const Duration(milliseconds: 500), () {
      state = state.copyWith(
        recorridosFiltrados: state.recorridos,
        isFiltered: false,
      );
    });
  }

  @override
  void cleanTipoSucursalFilter() {
    _timer?.cancel();

    state = state.copyWith(
      isFiltered: true,
      filtersSucursales: state.filtersSucursales.copyWith(tipoSucursal: null),
    );

    checkFilters();

    _timer = Timer(const Duration(milliseconds: 500), () {
      state = state.copyWith(
        recorridosFiltrados: state.recorridos,
        isFiltered: false,
      );
    });
  }

  @override
  void filterRegion(String? region) {
    _timer?.cancel();

    state = state.copyWith(
      filtersSucursales: state.filtersSucursales.copyWith(region: region),
      isFiltered: true,
    );

    checkFilters();

    if (region == null) {
      _timer = Timer(const Duration(milliseconds: 500), () {
        state = state.copyWith(
          recorridosFiltrados: state.recorridos,
          isFiltered: false,
        );
      });
      return;
    }

    _timer = Timer(const Duration(milliseconds: 500), () {
      // obtenemos los recorridos actuales
      final recorridos = state.recorridos;

      // filtramos los recorridos por folio y nombre
      final recorridosFiltrados = recorridos.where((recorrido) {
        return recorrido.region.toLowerCase().contains(region.toLowerCase());
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

  @override
  filterListSucursales(String filter) {
    _timer?.cancel();

    state = state.copyWith(
      filtersSucursales: state.filtersSucursales.copyWith(
        sucursal: filter,
      ),
      isFiltered: true,
    );

    checkFilters();

    if (filter.trim().isEmpty) {
      _timer = Timer(const Duration(milliseconds: 500), () {
        state = state.copyWith(
          recorridosFiltrados: state.recorridos,
          isFiltered: false,
        );
      });
      return;
    }

    _timer = Timer(const Duration(milliseconds: 500), () {
      // obtenemos los recorridos actuales
      final recorridos = state.recorridos;

      // filtramos los recorridos por folio y nombre
      final recorridosFiltrados = recorridos.where((recorrido) {
        return recorrido.folio.toLowerCase().contains(filter.toLowerCase()) ||
            recorrido.nombre.toLowerCase().contains(filter.toLowerCase()) ||
            recorrido.checklist.value.toLowerCase().contains(filter.toLowerCase()) ||
            recorrido.region.toLowerCase().contains(filter.toLowerCase()) ||
            recorrido.tipo.value.toLowerCase().contains(filter.toLowerCase());
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

  @override
  void filterStatusRecorridoSucursal(StatusRecorridoSucursalType status) {
    _timer?.cancel();
    state = state.copyWith(
      filtersSucursales: state.filtersSucursales.copyWith(filterStatusSucursal: status),
      isFiltered: true,
    );

    checkFilters();

    if (status == StatusRecorridoSucursalType.todos) {
      _timer = Timer(const Duration(milliseconds: 500), () {
        state = state.copyWith(
          recorridosFiltrados: state.recorridos,
          isFiltered: false,
        );
      });
      return;
    }

    print('filterStatusSucursal: ${state.filtersSucursales}');

    _timer = Timer(const Duration(milliseconds: 500), () {
      // obtenemos los recorridos actuales
      final recorridos = state.recorridos;

      // filtramos los recorridos por folio y nombre
      final recorridosFiltrados = recorridos.where((recorrido) {
        return recorrido.checklist == status;
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

  @override
  void filterTipoSucursal(TipoSucursalType? tipo) {
    _timer?.cancel();
    state = state.copyWith(
      filtersSucursales: state.filtersSucursales.copyWith(tipoSucursal: tipo),
      isFiltered: true,
    );

    checkFilters();

    if (tipo == null) {
      _timer = Timer(const Duration(milliseconds: 500), () {
        state = state.copyWith(
          recorridosFiltrados: state.recorridos,
          isFiltered: false,
        );
      });
      return;
    }

    _timer = Timer(const Duration(milliseconds: 500), () {
      // obtenemos los recorridos actuales
      final recorridos = state.recorridos;

      // filtramos los recorridos por folio y nombre
      final recorridosFiltrados = recorridos.where((recorrido) {
        return recorrido.tipo == tipo;
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

  // check if we have filters if we have, return true, else return false
  checkFilters() {
    final filters = state.filtersSucursales;
    if (filters.region != null ||
        filters.sucursal != null ||
        filters.tipoSucursal != null ||
        filters.filterStatusSucursal != StatusRecorridoSucursalType.todos) {
      state = state.copyWith(
        filtersSucursales: filters.copyWith(hasFilters: true),
      );
      return;
    }
    state = state.copyWith(
      filtersSucursales: filters.copyWith(hasFilters: false),
    );
  }
}

abstract class RecorridosMantenimientoInput {
  void getRecorridosMantenimiento();
}

abstract class FiltrosSucursalesInput {
  void filterStatusRecorridoSucursal(StatusRecorridoSucursalType status);
  void filterListSucursales(String filter);
  void filterTipoSucursal(TipoSucursalType? tipo);
  void filterRegion(String region);

  void cleanStatusFilter();
  void cleanTipoSucursalFilter();
  void cleanRegionFilter();
  void cleanFilters();
}
