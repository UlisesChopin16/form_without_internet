import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/common/components/drop_down_menu_base.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view_model/recorridos_mantenimiento_view_model.dart';
import 'package:form_without_internet/types/tipo_sucursal_type.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilterTipoSucursalComponent extends ConsumerStatefulWidget {
  const FilterTipoSucursalComponent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilterTipoSucursalComponentState();
}

class _FilterTipoSucursalComponentState extends ConsumerState<FilterTipoSucursalComponent> {
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
    // final tipo = ref.watch(
    //   recorridosMantenimientoViewModelProvider.select(
    //     (value) => value.filtersSucursales?.tipoSucursal,
    //   ),
    // );
    final tipo = ref.watch(
      recorridosMantenimientoViewModelProvider.select(
        (value) => value.filtersSucursales.tipoSucursal,
      ),
    );
    if (tipo == null) {
      controller.clear();
      activateClean = false;
    } else {
      controller.text = tipo.value;
      activateClean = true;
    }
    return Column(
      children: [
        const Text(
          'Filtrar por tipo',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(10),
        DropDownMenuBase<TipoSucursalType>(
          controller: controller,
          onSelected: (value) {
            ref.read(recorridosMantenimientoViewModelProvider.notifier).filterTipoSucursal(value);
          },
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          activateClean: activateClean,
          onClear: () {
            controller.clear();
            ref.read(recorridosMantenimientoViewModelProvider.notifier).cleanTipoSucursalFilter();
          },
          label: 'Tipo de sucursal',
          dropdownMenuEntries: TipoSucursalType.values
              .map(
                (e) => DropdownMenuEntry(value: e, label: e.value.toString()),
              )
              .toList(),
        ),
      ],
    );
  }
}
