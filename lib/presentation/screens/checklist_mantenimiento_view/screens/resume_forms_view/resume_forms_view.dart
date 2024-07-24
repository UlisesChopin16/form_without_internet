import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/hooks/use_launch_effect.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/resume_forms_view/resume_forms_view_model/resume_forms_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/components.dart';

class ResumeFormsView extends HookConsumerWidget {
  final String section;
  final String listOf;
  final String folio;

  const ResumeFormsView({
    super.key,
    required this.listOf,
    required this.folio,
    required this.section,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    useLaunchEffect(() async {
      await ref.read(listFormsViewModelProvider.notifier).getForms([listOf, folio, 'true']);
      final forms = ref.read(listFormsViewModelProvider.select((value) => value.data));
      ref.read(resumeFormsViewModelProvider.notifier).generateListExpandeds(forms.length);
    });

    final (forms, isLoading) = ref.watch(
      listFormsViewModelProvider.select(
        (value) => (value.data, value.isLoading),
      ),
    );
    final (listExpandeds) =
        ref.watch(resumeFormsViewModelProvider.select((value) => value.listExpandeds));

    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : forms.isEmpty || listExpandeds.isEmpty
              ? const Center(
                  child: Text('No hay resumenes disponibles'),
                )
              : const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ButtonExpandedComponent(),
                    ListResumsComponent(),
                  ],
                ),
    );
  }
}
