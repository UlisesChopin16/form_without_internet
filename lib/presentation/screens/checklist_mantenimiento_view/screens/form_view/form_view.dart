import 'package:flutter/material.dart';
import 'package:form_without_internet/domain/models/list_forms_response_model/list_forms_response_model.dart';
import 'package:form_without_internet/presentation/common/components/saving_data_component.dart';
import 'package:form_without_internet/presentation/hooks/use_launch_effect.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/form_view/form_view_model/form_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/components.dart';

class FormView extends HookConsumerWidget {
  final int formIndex;
  final String title;
  final List<QuestionsResponseModel> questions;
  const FormView(
      {super.key, required this.questions, required this.title, required this.formIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useLaunchEffect(
      () => ref.read(formViewModelProvider.notifier).getQuestions(questions, title, formIndex),
    );
    final (isExpanded, isSaving, isSaved) = ref.watch(
        formViewModelProvider.select((value) => (value.isExpanded, value.isSaving, value.isSaved)));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        actions: [
          SavingDataComponent(
            isSaving: isSaving,
            isSaved: isSaved,
          )
        ],
      ),
      body: Center(
        child: isExpanded.isEmpty
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) => ExpandedContainerComponent(
                  index: index,
                ),
              ),
      ),
    );
  }
}
