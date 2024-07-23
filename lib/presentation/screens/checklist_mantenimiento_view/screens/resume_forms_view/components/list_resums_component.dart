import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/components/text_inactive_section_component.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/resume_forms_view/resume_forms_view_model/resume_forms_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components.dart';

class ListResumsComponent extends HookConsumerWidget {
  const ListResumsComponent({
    super.key,
  });

  static const TextStyle style = TextStyle(
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final (forms) = ref.watch(listFormsViewModelProvider.select((value) => value.data));
    final (listExpandeds) =
        ref.watch(resumeFormsViewModelProvider.select((value) => value.listExpandeds));
    return ListView.builder(
      controller: scrollController,
      itemCount: forms.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 65,
      ),
      itemBuilder: (context, index) {
        final form = forms[index];
        final isExpanded = listExpandeds[index];
        return Card(
          color: Colors.grey[350],
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: InkWell(
              onTap: form.active
                  ? () => ref.read(resumeFormsViewModelProvider.notifier).changeExpanded(index)
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HeaderResumeFormComponen(form: form, index: index),
                  const SizedBox(height: 5),
                  const Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  const SizedBox(height: 15),
                  if (form.active)
                    isExpanded
                        ? BodyResumeFormComponent(
                            questionsResponseModel: form.questionsResponseModel,
                          )
                        : const SizedBox()
                  else
                    const TextInactiveSectionComponent(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
