import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/common/components/drop_down_menu_base.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view_model/recorridos_mantenimiento_view_model.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilterRegionSucursalComponent extends ConsumerStatefulWidget {
  const FilterRegionSucursalComponent({super.key});

  @override
  ConsumerState<FilterRegionSucursalComponent> createState() =>
      _FilterRegionSucursalComponentState();
}

class _FilterRegionSucursalComponentState extends ConsumerState<FilterRegionSucursalComponent> {
  final TextEditingController controller = TextEditingController();
  bool activateClean = false;
  static const regiones = [
    'Región 1',
    'Región 2',
    'Región 3',
    'Región 4',
    'Región 5',
    'Región 6',
    'Región 7',
    'Región 8',
    'Región 9',
    'Región 10',
    'Región 11',
    'Región 12',
    'Región 13',
    'Región 14',
    'Región 15',
    'Región 16',
    'Región 17',
  ];

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

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    controller.dispose();
    controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final region = ref.watch(
      recorridosMantenimientoViewModelProvider.select(
        (value) => value.filtersSucursales.region,
      ),
    );

    if (region == null) {
      controller.clear();
      activateClean = false;
    } else {
      controller.text = region;
      activateClean = true;
    }

    return Column(
      children: [
        const Text(
          'Filtrar por región',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(10),
        DropDownMenuBase<String>(
          controller: controller,
          onSelected: (value) {
            ref.read(recorridosMantenimientoViewModelProvider.notifier).filterRegion(value);
          },
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          activateClean: activateClean,
          onClear: () {
            controller.clear();
            ref.read(recorridosMantenimientoViewModelProvider.notifier).cleanRegionFilter();
          },
          label: 'Región',
          dropdownMenuEntries: regiones
              .map(
                (region) => DropdownMenuEntry(
                  value: region,
                  label: region,
                  labelWidget: Text(
                    region,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
