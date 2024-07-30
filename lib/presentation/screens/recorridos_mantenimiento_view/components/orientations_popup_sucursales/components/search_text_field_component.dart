import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view_model/recorridos_mantenimiento_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchTextFieldComponent extends ConsumerStatefulWidget {
  const SearchTextFieldComponent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchTextFieldComponentState();
}

class _SearchTextFieldComponentState extends ConsumerState<SearchTextFieldComponent> {
  final TextEditingController controller = TextEditingController();
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final search = ref.watch(
        recorridosMantenimientoViewModelProvider.select(
          (value) => value.filtersSucursales.sucursal,
        ),
      );
      setState(() {
        if (search == null) {
          controller.clear();
          activateClean = false;
        } else {
          controller.text = search;
          activateClean = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Buscar...',
        prefixIcon: activateClean
            ? IconButton(
                icon: const Icon(
                  Icons.cancel_rounded,
                  color: Colors.red,
                ),
                onPressed: () {
                  controller.clear();
                  ref
                      .read(recorridosMantenimientoViewModelProvider.notifier)
                      .filterListSucursales('');
                },
              )
            : const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: ref.read(recorridosMantenimientoViewModelProvider.notifier).filterListSucursales,
    );
  }
}
