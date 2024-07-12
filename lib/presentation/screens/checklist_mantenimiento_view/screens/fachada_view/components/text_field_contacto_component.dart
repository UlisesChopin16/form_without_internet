import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/fachada_view/fachada_view_model/fachada_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TextFieldContactoComponent extends HookConsumerWidget {
  const TextFieldContactoComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    final controller = useTextEditingController();
    final contacto =
        ref.watch(fachadaViewModelProvider.select((value) => (value.telefonoContacto)));
    controller.text = contacto;
    return TextFormField(
      controller: controller,
      onChanged: ref.read(fachadaViewModelProvider.notifier).onChangeTelefonoContacto,
      decoration: const InputDecoration(
        labelText: 'No. de contacto',
        hintText: 'Teléfono o celular',
        border: OutlineInputBorder(),
      ),
    );
  }
}
