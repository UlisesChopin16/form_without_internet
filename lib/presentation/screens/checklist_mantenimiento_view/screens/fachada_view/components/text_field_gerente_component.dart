import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/fachada_view/fachada_view_model/fachada_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TextFieldGerenteComponent extends HookConsumerWidget {
  const TextFieldGerenteComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    final controller = useTextEditingController();
    final (gerente, isResume) =
        ref.watch(fachadaViewModelProvider.select((value) => (value.gerente, value.isResume)));
    controller.text = gerente;
    return TextFormField(
      // keyboard.next
      controller: controller,
      style: const TextStyle(fontSize: 16.0, color: Colors.black),
      onChanged: ref.read(fachadaViewModelProvider.notifier).onChangeGerente,

      decoration: InputDecoration(
        labelText: 'Gerente de sucursal',
        enabled: isResume ? false : true,
        border: const OutlineInputBorder(),
        disabledBorder: const OutlineInputBorder(),
      ),
    );
  }
}
