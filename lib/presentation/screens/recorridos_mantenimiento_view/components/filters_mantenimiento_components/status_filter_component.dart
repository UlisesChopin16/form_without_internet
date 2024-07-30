import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/common/components/drop_down_menu_base.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view_model/recorridos_mantenimiento_view_model.dart';
import 'package:form_without_internet/types/status_recorrido_mantenimiento_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StatusFilterComponent extends ConsumerStatefulWidget {
  const StatusFilterComponent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StatusFilterComponentState();
}

class _StatusFilterComponentState extends ConsumerState<StatusFilterComponent> {
  TextEditingController controller = TextEditingController();
  bool activateClean = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        if (controller.text.isEmpty) {
          activateClean = false;
          return;
        }
        activateClean = true;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(
      recorridosMantenimientoViewModelProvider.select(
        (value) => value.filterStatusMant,
      ),
    );
    return DropDownMenuBase(
      controller: controller,
      activateClean: activateClean,
      onSelected:
          ref.read(recorridosMantenimientoViewModelProvider.notifier).filterStatusRecorridoMant,
      textStyle: TextStyle(
        color: status?.color ?? Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      onClear: () {
        controller.clear();
        ref
            .read(recorridosMantenimientoViewModelProvider.notifier)
            .clearFilterStatusRecorridoMant();
      },
      label: 'Estatus',
      dropdownMenuEntries: [
        DropdownMenuEntry(
          label: 'Pendientes',
          labelWidget: Text(
            'Pendientes',
            style: TextStyle(
              color: StatusRecorridoMantenimientoType.pendiente.color,
              fontWeight: FontWeight.bold,
            ),
          ),
          value: StatusRecorridoMantenimientoType.pendiente,
        ),
        DropdownMenuEntry(
          label: 'En curso',
          labelWidget: Text(
            'En curso',
            style: TextStyle(
              color: StatusRecorridoMantenimientoType.enCurso.color,
              fontWeight: FontWeight.bold,
            ),
          ),
          value: StatusRecorridoMantenimientoType.enCurso,
        ),
        // completados
        DropdownMenuEntry(
          label: 'Completados',
          labelWidget: Text(
            'Completados',
            style: TextStyle(
              color: StatusRecorridoMantenimientoType.completado.color,
              fontWeight: FontWeight.bold,
            ),
          ),
          value: StatusRecorridoMantenimientoType.completado,
        ),
      ],
    );
  }
}
