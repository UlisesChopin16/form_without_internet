import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/fachada_view/fachada_view_model/fachada_view_model.dart';

class TextFieldGerenteComponent extends ConsumerWidget {
  const TextFieldGerenteComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    return TextFormField(
      // keyboard.next
      onChanged: ref.read(fachadaViewModelProvider.notifier).onChangeGerente,
      decoration: const InputDecoration(
        labelText: 'Gerente de sucursal',
        border: OutlineInputBorder(),
      ),
    );
  }
}
