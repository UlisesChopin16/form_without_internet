import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/common/components/button_base_component.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view_model/recorridos_mantenimiento_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonFiltrarRecorridoMComponent extends ConsumerWidget {
  const ButtonFiltrarRecorridoMComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(
      recorridosMantenimientoViewModelProvider.select(
        (value) => value.expandFiltersM,
      ),
    );
    return ButtonBaseComponent(
      onPressed: () {
        ref.read(recorridosMantenimientoViewModelProvider.notifier).expandFiltersM();
      },
      child: isExpanded
          ? const Icon(
              Icons.close_rounded,
              color: Colors.white,
            )
          : const Text(
              'Filtrar recorridos',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
    );
  }
}
