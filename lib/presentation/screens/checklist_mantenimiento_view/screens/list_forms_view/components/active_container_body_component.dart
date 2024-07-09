import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/common/components/label_text_component.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ActiveContainerBodyComponent extends ConsumerWidget {
  final int index;
  const ActiveContainerBodyComponent({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (lenght, isActive) = ref.watch(
      listFormsViewModelProvider.select(
        (value) => (value.data[index].questionsResponseModel.length, value.data[index].active),
      ),
    );
    final completedsAndNot =
        ref.read(listFormsViewModelProvider.notifier).getCompletedsAndNot(index);
    return AnimatedOpacity(
      duration: Duration(milliseconds: isActive ? 500 : 300),
      curve: Curves.easeInOut,
      opacity: isActive ? 1 : 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // cantidad de preguntas
          LabelTextComponent(
            label: 'Totales',
            text: '$lenght',
            fontSize: 14,
          ),
          // respuestas contestadas
          LabelTextComponent(
            label: 'Contestadas',
            text: '${completedsAndNot[0]}',
            fontSize: 14,
            colorText: Colors.green,
          ),
          // respuestas sin contestar
          LabelTextComponent(
            label: 'Sin contestar',
            text: '${completedsAndNot[1]}',
            fontSize: 14,
            colorText: Colors.red,
          ),
        ],
      ),
    );
  }
}
