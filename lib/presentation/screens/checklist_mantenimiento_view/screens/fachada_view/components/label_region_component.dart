import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_without_internet/presentation/common/components/label_text_component.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/fachada_view/fachada_view_model/fachada_view_model.dart';

class LabelRegionComponent extends ConsumerWidget {
  const LabelRegionComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    final region = ref.watch(fachadaViewModelProvider.select((value) => (value.recorrido?.region)));
    return LabelTextComponent(
      label: 'Región',
      text: region ?? '',
      fontSize: 14,
    );
  }
}
