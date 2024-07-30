import 'package:flutter/material.dart';
import 'package:form_without_internet/domain/models/recorridos_mantenimiento_response_model/recorridos_mantenimiento_response_model.dart';
import 'package:form_without_internet/presentation/common/components/close_button_component.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/components/label_content_component.dart';
import 'package:gap/gap.dart';

import 'pop_up_detalles_sucursal_components/pop_up_detalles_sucursal_components.dart';

class PopupDetalleSucursalComponent extends StatelessWidget {
  final RecorridoSucursalModel recorrido;
  final bool disapearButton;
  const PopupDetalleSucursalComponent({
    super.key,
    required this.recorrido,
    this.disapearButton = false,
  });

  static const style = TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Detalle de la sucursal:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        recorrido.nombre,
                        style: const TextStyle(
                          fontSize: 22,
                          // fontWeight: FontWeight.bold,
                        ),
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
                            style: style.copyWith(
                              color: recorrido.checklist.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(80),
                Text(
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
              ],
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 1.5,
            ),
          ],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelContentComponent(
                            label: 'Tipo:',
                            content: Text(
                              recorrido.tipo.value,
                              style: style,
                            ),
                          ),
                          const Gap(10),
                          LabelContentComponent(
                            label: 'Región:',
                            content: Text(
                              recorrido.region,
                              style: style,
                            ),
                          ),
                          // fecha visita
                          const Gap(10),
                          const LabelContentComponent(
                            label: 'Fecha de visita:',
                            content: Text(
                              'Aún no se realiza la visita',
                              style: style,
                            ),
                          ),
                          const Gap(10),
                          const LabelContentComponent(
                            label: 'Dirección:',
                            content: Text(
                              'Constituyentes no. 13 col. Centro, Santiago de Queretaro. CP. 76057',
                              style: style,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // fecha programada
                          const LabelContentComponent(
                            label: 'Fecha programada:',
                            content: Text(
                              'sem.28 del 08/Jul/2024 al\n14/Jul/2024',
                              style: style,
                            ),
                          ),
                          const Gap(15),
                          // fecha de inicio
                          ButtonPlanoComponent(
                            statusRecorrido: recorrido.checklist,
                            folio: recorrido.folio,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const CloseButtonComponent(),
            const Gap(10),
            if (!disapearButton) ButtonChecklistComponent(recorrido: recorrido),
          ],
        ),
      ],
    );
  }
}
