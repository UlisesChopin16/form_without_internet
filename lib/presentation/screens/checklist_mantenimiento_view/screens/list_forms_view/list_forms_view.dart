import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/hooks/use_launch_effect.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/components/active_container_component.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/components.dart';

class ListFormsView extends HookConsumerWidget {
  final String section;
  final String listOf;
  final String folio;
  const ListFormsView(
      {super.key, required this.listOf, required this.folio, required this.section});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orientation = MediaQuery.of(context).orientation;
    useLaunchEffect(
      () => ref.read(listFormsViewModelProvider.notifier).getForms([listOf, folio]),
    );

    final (forms, isLoading, isSaving, isSaved) = ref.watch(
      listFormsViewModelProvider.select(
        (value) => (value.data, value.isLoading, value.isSaving, value.isSaved),
      ),
    );
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    return Scaffold(
        body: !isLoading
            ? Padding(
                padding: const EdgeInsets.only(
                  right: 10.0,
                  left: 10.0,
                  top: 10.0,
                  bottom: 25,
                ),
                child: forms.isNotEmpty
                    ? GridView.builder(
                        padding: const EdgeInsets.only(bottom: 60.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: (orientation == Orientation.portrait) ? 4 : 5,
                          mainAxisSpacing: 5.0,
                        ),
                        itemCount: forms.length,
                        itemBuilder: (context, index) {
                          return ActiveContainerComponent(
                            index: index,
                          );
                        },
                      )
                    : Center(
                        child: Text('No hay $section disponibles'),
                      ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
