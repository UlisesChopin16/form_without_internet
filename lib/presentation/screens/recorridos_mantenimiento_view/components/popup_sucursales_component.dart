import 'package:flutter/material.dart';
import 'package:form_without_internet/constants/icons_manager.dart';
import 'package:form_without_internet/constants/strings_manager.dart';
import 'package:form_without_internet/domain/models/recorridos_mantenimiento_response_model/recorridos_mantenimiento_response_model.dart';
import 'package:form_without_internet/presentation/common/components/close_button_component.dart';
import 'package:form_without_internet/presentation/common/components/label_text_component.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/components/label_content_component.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/components/popup_detalle_sucursal_component.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view_model/recorridos_mantenimiento_view_model.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PopupSucursalesComponent extends ConsumerWidget {
  final int index;
  final Color color;

  const PopupSucursalesComponent({
    super.key,
    required this.index,
    required this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (recorridosFiltrados, isFiltering) = ref.watch(
      recorridosMantenimientoViewModelProvider.select(
        (value) => (value.recorridosFiltrados, value.isFiltered),
      ),
    );
    double height = recorridosFiltrados.length < 3 ? 250 : 400;
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelContentComponent(
            label: 'Recorridos:',
            content: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  IconsManager.iconsStatusAssigment[index],
                  color: color,
                ),
                const Gap(5),
                Text(
                  StringsManager.sucursalesColumn[index],
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Buscar...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: ref.read(recorridosMantenimientoViewModelProvider.notifier).filterList,
          ),
        ],
      ),
      content: SizedBox(
        height: height,
        width: 400,
        child: !isFiltering
            ? ListView.builder(
                itemCount: recorridosFiltrados.length,
                itemBuilder: (context, index) {
                  final recorrido = recorridosFiltrados[index];
                  return InkWell(
                    onTap: () {
                      onTap(context, recorrido);
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.only(
                        top: 4,
                        right: 4,
                        left: 4,
                        bottom: 10,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: color,
                              width: 15,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Text(
                                      recorrido.nombre,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Text(
                                    recorrido.folio,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.blue,
                                      fontWeight: FontWeight.w500,
                                      decorationThickness: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                const Gap(5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      recorrido.checklist.icon,
                                      color: recorrido.checklist.color,
                                    ),
                                    const Gap(5),
                                    Text(
                                      recorrido.checklist.value,
                                      style: TextStyle(
                                        color: recorrido.checklist.color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
      actions: [
        CloseButtonComponent(
          onPressed: () {
            ref.read(recorridosMantenimientoViewModelProvider.notifier).cleanListFiltered();
          },
        ),
      ],
    );
  }

  onTap(BuildContext context, RecorridoSucursalModel recorrido) {
    showDialog(
        context: context,
        builder: (context) => PopupDetalleSucursalComponent(
              recorrido: recorrido,
            ));
  }
}
