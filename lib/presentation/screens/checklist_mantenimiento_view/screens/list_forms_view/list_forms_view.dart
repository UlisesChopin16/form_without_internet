import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/hooks/use_launch_effect.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/components/active_container_component.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/list_forms_view/list_forms_view_model/list_forms_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'components/components.dart';

class ListFormsView extends HookConsumerWidget {
  final String listOf;
  const ListFormsView({super.key, required this.listOf});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useLaunchEffect(
      () => ref.read(listFormsViewModelProvider.notifier).getForms(listOf),
    );

    final (forms) = ref.watch(
      listFormsViewModelProvider.select(
        (value) => (value.data),
      ),
    );
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 25.0,
        ),
        child: Wrap(
          children: List.generate(
            forms.length,
            (index) {
              return ActiveContainerComponent(
                index: index,
              );
            },
          ),
        ),
      ),
    );
  }
}
