import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/components/orientations_popup_sucursales/components/components.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view_model/recorridos_mantenimiento_view_model.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../filters_sucursales_components/filters_sucursales_components.dart';

class ExpandedFiltersSComponent extends ConsumerWidget {
  const ExpandedFiltersSComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orientation = MediaQuery.of(context).orientation;
    final (isExpanded, hasFilters) = ref.watch(
      recorridosMantenimientoViewModelProvider.select(
        (value) => (value.expandFiltersS, value.filtersSucursales.hasFilters),
      ),
    );

    bool portrait = orientation == Orientation.portrait;
    bool landscape = orientation == Orientation.landscape;

    double? height = 0;
    if (landscape) {
      height = null;
    } else {
      height = isExpanded ? 350 : 0;
    }

    final row = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (landscape && hasFilters)
          const Align(
            alignment: Alignment.topRight,
            child: ButtonClearFiltersComponent(),
          ),
        if (portrait)
          IconButton(
            onPressed: ref.read(recorridosMantenimientoViewModelProvider.notifier).expandFiltersS,
            icon: const Icon(
              Icons.cancel,
            ),
            color: Theme.of(context).primaryColor,
            iconSize: 30,
          )
      ],
    );

    final child = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (landscape)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: row,
            ),
          const Gap(10),
          const FilterStatusSucursalComponent(),
          if (orientation == Orientation.portrait) const Gap(20) else const Gap(40),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(child: FilterTipoSucursalComponent()),
              Gap(20),
              Flexible(child: FilterRegionSucursalComponent()),
            ],
          ),
        ],
      ),
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(10),
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: landscape
          ? child
          : Column(
              children: [
                row,
                Center(
                  child: child,
                ),
              ],
            ),
    );
  }
}
