import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/common/components/close_button_component.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view_model/recorridos_mantenimiento_view_model.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/components.dart';

class PortraitPopupComponent extends ConsumerWidget {
  final int index;
  final Color color;
  const PortraitPopupComponent({super.key, required this.index, required this.color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasFilters = ref.watch(
      recorridosMantenimientoViewModelProvider.select(
        (value) => value.filtersSucursales.hasFilters,
      ),
    );
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderPopupComponent(
            index: index,
            color: color,
          ),
          const Gap(10),
          const SearchTextFieldComponent(),
          const Gap(5),
          // BONTON DE FILTRAR
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (hasFilters) const ButtonClearFiltersComponent(),
              const ButtonFiltersComponent(),
            ],
          ),
          const ExpandedFiltersSComponent(),
        ],
      ),
      content: ListSucursalesComponent(
        color: color,
      ),
      actions: [
        CloseButtonComponent(
          onPressed: () {
            ref
                .read(recorridosMantenimientoViewModelProvider.notifier)
                .cleanListSucursalesFiltered();
          },
        ),
      ],
    );
  }
}
