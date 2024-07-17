import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/hooks/use_launch_effect.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/checklist_mantenimiento_view.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view_model/recorridos_mantenimiento_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RecorridosMantenimientoView(),
      // home: const NewWidget(),
    );
  }
}

class NewWidget extends HookConsumerWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useLaunchEffect(
      ref.read(recorridosMantenimientoViewModelProvider.notifier).getRecorridosMantenimiento,
    );

    final (listRecorridos, isLoading) = ref.watch(
      recorridosMantenimientoViewModelProvider.select(
        (value) => (value.data, value.isLoading),
      ),
    );

    const List<String> columnNames = [
      'sem',
      'Inicio',
      'Fin',
      // 'Responsable',
      'Recorrido sucursales',
      'Estatus',
      // 'Fecha registro',
      'Op.',
    ];

    const List<String> sucursalesColumn = [
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
      body: ListView(
        children: [
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else
            SizedBox(
              height: 64,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: columnNames
                    .map(
                      (columnName) => (columnName == 'Recorrido sucursales')
                          ? Expanded(
                              flex: 10,
                              child: DataCellComponent(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    HeaderTextComponent(text: columnName),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: Row(
                                        children: sucursalesColumn
                                            .map(
                                              (sucursalColumn) => Expanded(
                                                child: HeaderTextComponent(text: sucursalColumn),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Expanded(
                              flex: (columnName == 'sem') ? 1 : 2,
                              child: DataCellComponent(
                                child: HeaderTextComponent(text: columnName),
                              ),
                            ),
                    )
                    .toList(),
              ),
            ),
          if (!isLoading)
            ...listRecorridos.map(
              (recorrido) {
                return IntrinsicHeight(
                  child: IntrinsicWidth(
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 1,
                          child: DataCellComponent(
                            child: ContentTextComponent(
                              recorrido.sem.toString(),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: DataCellComponent(
                            child: ContentTextComponent(
                              recorrido.inicio,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: DataCellComponent(
                            child: ContentTextComponent(
                              recorrido.fin,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: IntrinsicWidth(
                            child: DataCellComponent(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: recorrido.recorridoSucursalModels
                                    .map(
                                      (sucursal) => InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => ChecklistMantenimientoView(
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
                                                child: IntrinsicWidth(
                                                  child: Text(
                                                    sucursal.folio,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: Colors.blue,
                                                      decoration: TextDecoration.underline,
                                                      decorationColor: Colors.blue,
                                                      fontWeight: FontWeight.w500,
                                                      decorationThickness: 1.5,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: ContentTextComponent(
                                                  sucursal.nombre,
                                                ),
                                              ),
                                              Expanded(
                                                child: ContentTextComponent(
                                                  sucursal.tipo,
                                                ),
                                              ),
                                              Expanded(
                                                child: ContentTextComponent(
                                                  sucursal.region,
                                                ),
                                              ),
                                              Expanded(
                                                child: ContentTextComponent(
                                                  sucursal.checklist.name,
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
                        Expanded(
                          flex: 2,
                          child: DataCellComponent(
                            child: ContentTextComponent(
                              recorrido.status.value,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: DataCellComponent(
                            child: Center(
                              child: Wrap(
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
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class DataCellComponent extends StatelessWidget {
  final Widget child;
  const DataCellComponent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
      ),
      child: Center(child: child),
    );
  }
}

class HeaderTextComponent extends StatelessWidget {
  final String text;
  const HeaderTextComponent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class ContentTextComponent extends StatelessWidget {
  final String text;
  const ContentTextComponent(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
