import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/form_view/form_view_model/form_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components.dart';

class ExpandedBodyComponent extends HookConsumerWidget {
  final int index;
  const ExpandedBodyComponent({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final descriptionController = useTextEditingController();
    final (images, description, formIndex) = ref.watch(
      formViewModelProvider.select(
        (value) => (
          value.questions[index].images,
          value.questions[index].description,
          value.formIndex,
        ),
      ),
    );
    descriptionController.text = description;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextFormField(
                controller: descriptionController,
                maxLines: 3,
                onChanged: (value) {
                  ref.read(formViewModelProvider.notifier).onChangeDescription(
                    index,
                    value,
                    onSave: (questions) {
                      ref
                          .read(listFormsViewModelProvider.notifier)
                          .getQuestions(questions, formIndex);
                    },
                  );
                },
                decoration: const InputDecoration(
                  hintText: 'Descripciónes',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final heightC = constraints.maxHeight;
                final width = constraints.maxWidth / 4;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0),
                  child: Row(
                    children: [
                      if (images.length < 6)
                        ContainerAddImageComponent(
                          height: heightC,
                          width: width,
                          index: index,
                        ),
                      const Gap(10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: images.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, indexImage) => ContainerImageComponent(
                            image: images[indexImage],
                            height: heightC,
                            width: width,
                            onDelete: () => ref.read(formViewModelProvider.notifier).deleteImage(
                              index,
                              indexImage,
                              onDelete: (questions) {
                                ref
                                    .read(listFormsViewModelProvider.notifier)
                                    .getQuestions(questions, formIndex);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
