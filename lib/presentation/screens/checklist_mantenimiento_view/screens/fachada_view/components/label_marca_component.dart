import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_without_internet/presentation/common/components/label_text_component.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/fachada_view/fachada_view_model/fachada_view_model.dart';

class LabelMarcaComponent extends ConsumerWidget {
  const LabelMarcaComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    final marca = ref.watch(fachadaViewModelProvider.select((value) => (value.marca)));
    return LabelTextComponent(
      label: 'Marca',
      text: marca,
      fontSize: 14,
    );
  }
}