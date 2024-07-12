import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/hooks/use_launch_effect.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/checklist_mantenimiento_view.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view_model/recorridos_mantenimiento_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecorridosMantenimientoView extends HookConsumerWidget {
  const RecorridosMantenimientoView({super.key});
  static const border = BorderSide(
    width: 1,
    color: Colors.black,
  );
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
      // 'Responsable',
      'Recorrido sucursales',
      'Estatus',
      // 'Fecha registro',
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
          : ListView(
              children: [
                FittedBox(
                  child: DataTable(
                    horizontalMargin: 10,
                    headingRowHeight: 70,
                    dataRowMaxHeight: double.infinity,
                    dividerThickness: 0,
                    border: const TableBorder(
                      verticalInside: border,
                      bottom: border,
                      top: border,
                    ),
                    columns: columnNames
                        .map(
                          (columnName) => (columnName == 'Recorrido sucursales')
                              ? DataColumn(
                                  label: Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(columnName),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                                            child: Row(
                                              children: List.generate(
                                                sucursalesColumn.length,
                                                (index) => Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                    ),
                                                    child: Text(
                                                      sucursalesColumn[index],
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : DataColumn(
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
                              DataCell(
                                CenterText(
                                  text: recorrido.sem.toString(),
                                ),
                              ),
                              DataCell(
                                CenterText(text: recorrido.inicio),
                              ),
                              DataCell(
                                CenterText(text: recorrido.fin),
                              ),
                              // DataCell(
                              //   Align(
                              //     alignment: Alignment.center,
                              //     child: Text(recorrido.responsable),
                              //   ),
                              // ),
                              DataCell(
                                // placeholder: true,
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      children: recorrido.recorridoSucursalModels
                                          .map(
                                            (sucursal) => InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChecklistMantenimientoView(
                                                      folio: sucursal.folio,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        sucursal.folio,
                                                        style: const TextStyle(
                                                          color: Colors.blue,
                                                          decoration: TextDecoration.underline,
                                                          decorationColor: Colors.blue,
                                                          fontWeight: FontWeight.w500,
                                                          decorationThickness: 1.5,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: ConstrainedBox(
                                                        constraints: const BoxConstraints(
                                                          maxWidth: 100,
                                                        ),
                                                        child: Text(
                                                          sucursal.nombre,
                                                          overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        sucursal.tipo,
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        sucursal.region,
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        sucursal.checklist,
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                CenterText(
                                  text: recorrido.status,
                                ),
                              ),
                              // DataCell(Text(recorrido.fechaRegistro)),
                              DataCell(
                                Center(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        color: Colors.blue,
                                        icon: const Icon(Icons.edit_document),
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        color: Colors.red,
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
    );
  }
}

class CenterText extends StatelessWidget {
  final String text;
  const CenterText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}
