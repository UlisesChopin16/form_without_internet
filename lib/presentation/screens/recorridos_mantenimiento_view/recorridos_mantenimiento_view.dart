import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/hooks/use_launch_effect.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/checklist_mantenimiento_view.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view_model/recorridos_mantenimiento_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecorridosMantenimientoView extends HookConsumerWidget {
  const RecorridosMantenimientoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    // final orientation = MediaQuery.of(context).orientation;

    useLaunchEffect(
      ref.read(recorridosMantenimientoViewModelProvider.notifier).getRecorridosMantenimiento,
    );

    final (listRecorridos, isLoading) = ref.watch(
      recorridosMantenimientoViewModelProvider.select(
        (value) => (value.data, value.isLoading),
      ),
    );

    List<String> columnNames = [
      'sem',
      'Inicio',
      'Fin',
      'Responsable',
      'Recorrido sucursales',
      'Estatus',
      'Fecha registro',
      'Op.',
    ];

    List<String> sucursalesColumn = [
      'Folio',
      'Nombre',
      'Tipo',
      'Region',
      'Checklist',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recorridos de mantenimiento'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: FittedBox(
                child: DataTable(
                  dataRowMaxHeight: double.infinity,
                  columns: columnNames
                      .map(
                        (columnName) => DataColumn(
                          label: Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(columnName),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  rows: listRecorridos
                      .map(
                        (recorrido) => DataRow(
                          cells: [
                            DataCell(Text(recorrido.sem.toString())),
                            DataCell(Text(recorrido.inicio)),
                            DataCell(Text(recorrido.fin)),
                            DataCell(Text(recorrido.responsable)),
                            DataCell(
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: DataTable(
                                    showCheckboxColumn: false,
                                    columns: sucursalesColumn
                                        .map(
                                          (columnName) => DataColumn(
                                            label: Text(columnName),
                                          ),
                                        )
                                        .toList(),
                                    rows: recorrido.recorridoSucursalModels
                                        .map(
                                          (sucursal) => DataRow(
                                            onSelectChanged: (value) {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ChecklistMantenimientoView(),
                                                ),
                                              );
                                            },
                                            cells: [
                                              DataCell(Text(sucursal.folio)),
                                              DataCell(Text(sucursal.nombre)),
                                              DataCell(Text(sucursal.tipo)),
                                              DataCell(Text(sucursal.region)),
                                              DataCell(Text(sucursal.checklist)),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
                            DataCell(Text(recorrido.status)),
                            DataCell(Text(recorrido.fechaRegistro)),
                            DataCell(
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
    );
  }
}
