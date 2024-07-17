import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/hooks/use_launch_effect.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/resume_forms_view/components/list_resums_component.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    useLaunchEffect(
      () => ref.read(listFormsViewModelProvider.notifier).getForms([listOf, folio]),
    );

    final (forms, isLoading) = ref.watch(
      listFormsViewModelProvider.select(
        (value) => (value.data, value.isLoading),
      ),
    );
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : forms.isEmpty
              ? const Center(
                  child: Text('No hay resumenes disponibles'),
                )
              : ListResumsComponent(forms: forms),
    );
  }
}
