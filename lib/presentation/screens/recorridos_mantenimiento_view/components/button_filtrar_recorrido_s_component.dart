import 'package:flutter/material.dart';
import 'package:form_without_internet/domain/models/recorridos_mantenimiento_response_model/recorridos_mantenimiento_response_model.dart';
import 'package:form_without_internet/presentation/common/components/button_base_component.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/components/components.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view_model/recorridos_mantenimiento_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonFiltrarRecorridoSComponent extends ConsumerStatefulWidget {
  final List<Color> colors;
  const ButtonFiltrarRecorridoSComponent({super.key, required this.colors});

  @override
  ConsumerState<ButtonFiltrarRecorridoSComponent> createState() =>
      _ButtonFiltrarRecorridoSComponentState();
}

class _ButtonFiltrarRecorridoSComponentState
    extends ConsumerState<ButtonFiltrarRecorridoSComponent> {
  @override
  Widget build(BuildContext context) {
    return ButtonBaseComponent(
      onPressed: () {
        final recorridos =
            ref.read(recorridosMantenimientoViewModelProvider.notifier).getAllSucursales();
        onTap(recorridos, 3, widget.colors[3]);
      },
      child: const Text(
        'Filtrar sucursales',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  onTap(List<RecorridoSucursalModel> recorridos, int index, Color color) async {
    ref
        .read(recorridosMantenimientoViewModelProvider.notifier)
        .getListSucursalesFiltered(recorridos);
    await showDialog(
      context: context,
      builder: (context) {
        return PopupSucursalesComponent(
          color: color,
          index: index,
        );
      },
    );

    ref.read(recorridosMantenimientoViewModelProvider.notifier).cleanListSucursalesFiltered();
  }
}
