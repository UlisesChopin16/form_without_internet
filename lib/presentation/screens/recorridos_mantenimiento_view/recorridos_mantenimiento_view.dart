import 'package:flutter/material.dart';
import 'package:form_without_internet/constants/strings_manager.dart';
import 'package:form_without_internet/domain/models/recorridos_mantenimiento_response_model/recorridos_mantenimiento_response_model.dart';
import 'package:form_without_internet/presentation/common/components/center_text_component.dart';
import 'package:form_without_internet/presentation/hooks/use_launch_effect.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view_model/recorridos_mantenimiento_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/components.dart';

class RecorridosMantenimientoView extends StatefulHookConsumerWidget {
  const RecorridosMantenimientoView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecorridosMantenimientoViewState();
}

class _RecorridosMantenimientoViewState extends ConsumerState<RecorridosMantenimientoView> {
  // static const border = BorderSide(
  //   width: 1,
  //   color: Colors.black,
  // );


  static const List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.black,
  ];



  @override
  Widget build(BuildContext context) {
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
                    dataRowMaxHeight: double.infinity,
                    dividerThickness: 2,
                    columnSpacing: 30,
                    headingRowHeight: 98,
                    headingTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    border: const TableBorder(top: BorderSide(width: 2, color: Colors.black)),
                    columns: StringsManager.columnNames
                        .map(
                          (columnName) => (columnName == 'Recorrido sucursales')
                              ? DataColumn(
                                  label: Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 15.0, bottom: 5),
                                            child: Text(columnName),
                                          ),
                                          const Divider(
                                            thickness: 2,
                                            color: Colors.black,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                                            child: Row(
                                              children: StringsManager.sucursalesColumn
                                                  .map(
                                                    (sucursal) => Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                          horizontal: 5.0,
                                                        ),
                                                        child: Text(
                                                          sucursal,
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
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
                    rows: listRecorridos.map(
                      (recorrido) {
                        final index = listRecorridos.indexOf(recorrido);
                        final cantidades = ref
                            .read(recorridosMantenimientoViewModelProvider.notifier)
                            .cantidades(recorrido.recorridoSucursalModels);
                        final List<List<RecorridoSucursalModel>> cantidadRecorridos = cantidades['recorridos'];
                        final List<int> numeroCantidades = cantidades['cantidades'];
                        cantidadRecorridos.add(recorrido.recorridoSucursalModels);
                        final cells = [
                          recorrido.sem.toString(),
                          recorrido.inicio,
                          recorrido.fin,
                          // recorrido.responsable,
                        ];
                        return DataRow(
                          selected: ref
                              .read(recorridosMantenimientoViewModelProvider.notifier)
                              .trueOrFalse(index),
                          cells: [
                            ...cells.map(
                              (cell) => DataCell(
                                CenterTextComponent(
                                  text: cell,
                                ),
                              ),
                            ),
                            DataCell(
                              Row(
                                children: cantidadRecorridos
                                    .map(
                                      (recorridos) {
                                        final index = cantidadRecorridos.indexOf(recorridos);
                                        return Expanded(
                                          child: CantidadesTextComponent(
                                            onTap: () => onTap(recorridos, index, colors[index]),
                                            text: numeroCantidades[index].toString(),
                                            color: colors[index],
                                          ),
                                        );
                                      }
                                    )
                                    .toList()
                              ),
                            ),
                            DataCell(
                              CenterTextComponent(
                                text: recorrido.status.value,
                                style: TextStyle(
                                    color: recorrido.status.color, fontWeight: FontWeight.bold),
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
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
    );
  }

  onTap(List<RecorridoSucursalModel> recorridos, int index, Color color) async {
    ref.read(recorridosMantenimientoViewModelProvider.notifier).getListFiltered(recorridos);
    await showDialog(
      context: context,
      builder: (context) {
        return PopupSucursalesComponent(
          color: color,
          index: index,
        );
      },
    );

    ref.read(recorridosMantenimientoViewModelProvider.notifier).cleanListFiltered();
  }
}

class CantidadesTextComponent extends StatelessWidget {
  final String text;
  final Color color;
  final void Function() onTap;
  const CantidadesTextComponent({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: color,
          elevation: 3,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        child: CenterTextComponent(
          text: text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
