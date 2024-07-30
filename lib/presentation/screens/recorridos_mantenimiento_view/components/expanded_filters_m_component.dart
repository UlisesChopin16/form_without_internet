import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view_model/recorridos_mantenimiento_view_model.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'filters_mantenimiento_components/filters_mantenimiento_components.dart';

class ExpandedFiltersMComponent extends ConsumerStatefulWidget {
  const ExpandedFiltersMComponent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpandedFiltersMComponentState();
}

class _ExpandedFiltersMComponentState extends ConsumerState<ExpandedFiltersMComponent> {
  double height = 170;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isExpanded = ref.watch(
      recorridosMantenimientoViewModelProvider.select(
        (value) => value.expandFiltersM,
      ),
    );
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        border: isExpanded ? const Border(top: BorderSide(color: Colors.black, width: 2.5)) : null,
      ),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      height: isExpanded ? height : 0,
      width: width,
      child: Align(
        alignment: Alignment.centerRight,
        child: isExpanded
            ? const Column(
                children: [
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Limpiar filtros'),
                          Gap(5),
                          Icon(
                            Icons.cleaning_services_rounded,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(30),
                  StatusFilterComponent(),
                ],
              )
            : const SizedBox(),
      ),
    );
  }
}
