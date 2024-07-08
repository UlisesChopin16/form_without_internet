import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/fachada_view/fachada_view_model/fachada_view_model.dart';

class TextFieldContactoComponent extends ConsumerWidget {
  const TextFieldContactoComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    return TextFormField(
      onChanged: ref.read(fachadaViewModelProvider.notifier).onChangeTelefonoContacto,
      decoration: const InputDecoration(
        labelText: 'No. de contacto',
        hintText: 'Teléfono o celular',
        border: OutlineInputBorder(),
      ),
    );
  }
}
