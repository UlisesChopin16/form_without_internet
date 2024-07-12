import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/form_view/form_view_model/form_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';
import 'package:gap/gap.dart';

class ExpandedHeaderComponent extends ConsumerWidget {
  final int indexItem;
  const ExpandedHeaderComponent({super.key, required this.indexItem});

  static const List<String> titles = [
    'Excelente',
    'Bueno',
    'Regular',
    'Malo',
    'Pésimo',
    'No aplica',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (question, value) = ref.watch(
      formViewModelProvider.select(
        (value) => (value.questions[indexItem], value.questions[indexItem].value),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
      // padding: const EdgeInsets.only(horizontal: 10.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              question.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Gap(15),
          Expanded(
            flex: 3,
            child: Row(
              children: List.generate(
                titles.length,
                (index) {
                  return Expanded(
                    child: InkWell(
                      onTap: () {
                        onTap(ref, index);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            titles[index],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Radio(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            value: titles[index],
                            groupValue: value,
                            onChanged: (value) {
                              onTap(ref, index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  onTap(WidgetRef ref, int index) {
    ref.read(formViewModelProvider.notifier).changeValue(indexItem, titles[index]);
    ref.read(formViewModelProvider.notifier).changeSize(indexItem);

    final (questions, formIndex) = ref.watch(
      formViewModelProvider.select(
        (value) => (
          value.questions,
          value.formIndex,
        ),
      ),
    );

    ref.read(listFormsViewModelProvider.notifier).getQuestions(questions, formIndex);
  }
}
