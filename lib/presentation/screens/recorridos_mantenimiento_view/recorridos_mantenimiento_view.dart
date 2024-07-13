import 'package:flutter/material.dart';
import 'package:form_without_internet/domain/models/recorridos_mantenimiento_response_model/recorridos_mantenimiento_response_model.dart';
import 'package:form_without_internet/presentation/common/components/label_text_component.dart';
import 'package:form_without_internet/presentation/hooks/use_launch_effect.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/checklist_mantenimiento_view.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view_model/recorridos_mantenimiento_view_model.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

  static const List<String> columnNames = [
    'sem',
    'Inicio',
    'Fin',
    // 'Responsable',
    'Recorrido sucursales',
    'Estatus',
    // 'Fecha registro',
    'Op.',
  ];

  static const List<String> sucursalesColumn = [
    'Totales',
    'Pendientes',
    'En curso',
    'Completados',
  ];

  static const Color black = Colors.black;
  static const Color red = Colors.red;
  static const Color orange = Colors.orange;
  static const Color green = Colors.green;

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
                    headingRowHeight: 70,
                    dataRowMaxHeight: double.infinity,
                    dividerThickness: 2,
                    columnSpacing: 30,
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
                                                      horizontal: 5.0,
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
                    rows: listRecorridos.map(
                      (recorrido) {
                        final cantidades = ref
                            .read(recorridosMantenimientoViewModelProvider.notifier)
                            .cantidades(recorrido.recorridoSucursalModels);
                        final cantidadRecorridos = cantidades['recorridos'];
                        final numeroCantidades = cantidades['cantidades'];
                        return DataRow(
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
                              Row(
                                children: [
                                  // totales
                                  Expanded(
                                    child: CantidadesTextComponent(
                                      onTap: () =>
                                          onTap(recorrido.recorridoSucursalModels, 0, black),
                                      text: numeroCantidades[0].toString(),
                                      color: black,
                                    ),
                                  ),
                                  // pendientes
                                  Expanded(
                                    child: CantidadesTextComponent(
                                      onTap: () => onTap(cantidadRecorridos[0], 1, red),
                                      text: numeroCantidades[1].toString(),
                                      color: red,
                                    ),
                                  ),
                                  // en curso
                                  Expanded(
                                    child: CantidadesTextComponent(
                                      onTap: () => onTap(cantidadRecorridos[1], 2, orange),
                                      text: numeroCantidades[2].toString(),
                                      color: orange,
                                    ),
                                  ),
                                  // completados
                                  Expanded(
                                    child: CantidadesTextComponent(
                                      onTap: () => onTap(cantidadRecorridos[2], 3, green),
                                      text: numeroCantidades[3].toString(),
                                      color: green,
                                    ),
                                  ),
                                ],
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
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
    );
  }

  onTap(List<RecorridoSucursalModel> recorridos, int index, Color color) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Recorridos ${sucursalesColumn[index]}',
            style: TextStyle(
              color: color,
            ),
          ),
          content: FittedBox(
            child: SizedBox(
              height: recorridos.length < 3 ? 200 : 400,
              width: 400,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                ),
                itemCount: recorridos.length,
                itemBuilder: (context, index) {
                  final recorrido = recorridos[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChecklistMantenimientoView(
                            folio: recorrido.folio,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 25,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Text(
                                recorrido.nombre,
                                maxLines: 2,
                                style: TextStyle(
                                  color: color,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LabelTextComponent(
                                  label: 'Folio',
                                  text: recorrido.folio,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                    decorationThickness: 1.5,
                                  ),
                                ),
                                const Gap(5),
                                // Text('Tipo: ${recorrido.tipo}'),
                                LabelTextComponent(
                                  label: 'Tipo',
                                  text: recorrido.tipo,
                                ),
                                const Gap(5),
                                LabelTextComponent(
                                  label: 'Región',
                                  text: recorrido.region,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}

class CenterText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const CenterText({
    super.key,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: style,
      ),
    );
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
    return InkWell(
      onTap: onTap,
      child: CenterText(
        text: text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          decoration: TextDecoration.underline,
          decorationColor: color,
          decorationThickness: 1,
        ),
      ),
    );
  }
}
